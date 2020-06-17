defmodule RasaNLG.Connection do
  @moduledoc """
  Handle Tesla connections for RasaNLG.
  """

  use Tesla

  # Add any middleware here (authentication)
  plug Tesla.Middleware.BaseUrl, "http://localhost:5055/webhook"
  plug Tesla.Middleware.Headers, [{"user-agent", "Elixir"}]
  plug Tesla.Middleware.EncodeJson, engine: Poison

  @doc """
  Configure an authless client connection

  # Returns

  Tesla.Env.client
  """
  @spec new() :: Tesla.Env.client
  def new do
    Tesla.client([])
  end
end
