defmodule RasaNLG.Responses.Response do
  alias RasaNLG.Responses.Context

  @callback name() :: String.t()
  @callback run(Context.t()) :: Context.t()

  defmacro __using__(_) do
    quote do
      @behaviour RasaNLG.Responses.Response
      import RasaNLG.Responses.Context

      def name() do
        "#{__MODULE__}"|>String.split(".")|>Enum.reverse|>Enum.at(0)|>Macro.underscore()
      end
      def preprocess(%Context{} = context), do: context
      def respond(%Context{} = context), do: context
      def run(%Context{} = context) do
        context
        |> preprocess()
        |> respond()
      end
      defoverridable preprocess: 1,
                     name: 0,
                     respond: 1
    end
  end
end
