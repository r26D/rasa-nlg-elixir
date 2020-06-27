defmodule RasaNLG.Responses.Callback do
  @moduledoc """
  The rasa client can be configured to do call back - this module process those requests
  https://rasa.com/docs/rasa/user-guide/connectors/your-own-website/#rest-channels
  This ended up here instead of the Sdk because it is processing the same data that the NLG generates.
  """
  import Plug.Conn
  alias RasaNLG.Responses.Context

  def init(opts), do: opts
  def call(%Plug.Conn{body_params: body_params} = conn, opts) do

    context =
      body_params
      |> Poison.Decode.decode(as: %RasaNLG.Model.CallbackRequest{})
      |> Context.new()
      IO.inspect(opts)
      IO.inspect(context)
    conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Poison.encode!(%{msg: "success"}))
  end

end