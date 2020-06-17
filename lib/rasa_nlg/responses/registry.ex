defmodule RasaNLG.Responses.Registry do
  alias RasaNLG.Responses.Context

  def register_responses(modules) do
    responses_table = get_responses_table()
    :ets.new(responses_table, [:set, :protected, :named_table])

    modules
    |> Enum.each(fn module ->
      if RasaNLG.Responses.Response in (module.module_info(:attributes)[:behaviour] || []) do
        IO.puts("Registering #{module.name}")
        :ets.insert(responses_table, {module.name(), module})
      end
    end)
  end

  def execute(%Context{request: %{template: response_name}} = context) do
    case :ets.lookup(get_responses_table(), response_name) do
      [] ->
        context
        |> Context.set_error(response_name, "response not found")

      [{_, module}] ->
       IO.puts("Responding from #{response_name}")
        module.run(context)
    end
  end

  defp get_responses_table() do
    Application.get_env(:rasa_response, :responses_table, :rasa_responses)
  end
end
