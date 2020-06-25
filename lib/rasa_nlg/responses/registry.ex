defmodule RasaNLG.Responses.Registry do
  alias RasaNLG.Responses.Context

  def register_responses( modules) when is_list(modules) do
    register_responses({nil, modules})
  end
  def register_responses({prefix, modules}) do
    responses_table = get_responses_table()
    :ets.new(responses_table, [:set, :protected, :named_table])

    modules
    |> Enum.each(fn module ->
      if RasaNLG.Responses.Response in (module.module_info(:attributes)[:behaviour] || []) do
       # IO.puts("Registering #{key_name(prefix, module.name())}")
        :ets.insert(responses_table, {key_name(prefix, module.name()), module})
      end
    end)
  end

  defp key_name(nil, name), do: name
  defp key_name(prefix, name) do
    "#{prefix}/#{name}"
  end
  def execute(%Context{} = context), do: execute(context, [prefix: nil])
  def execute(%Context{request: %{template: response_name}} = context, [prefix: prefix]) do
 #   IO.puts("Going to look for #{key_name(prefix, response_name)}")
    case :ets.lookup(get_responses_table(), key_name(prefix, response_name)) do
      [] ->
       # IO.puts("Could not find it")
        context
        |> Context.set_error(response_name, "response not found")

      [{_, module}] ->
    #   IO.puts("Responding from #{key_name(prefix, response_name)}")
        module.run(context)
    end
  end

  defp get_responses_table() do
    Application.get_env(:rasa_response, :responses_table, :rasa_responses)
  end
end
