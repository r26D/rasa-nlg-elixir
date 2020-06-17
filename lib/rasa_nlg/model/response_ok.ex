defmodule RasaNLG.Model.ResponseOk do
  @moduledoc """
  Action was executed successfully.
  """
  alias RasaNLG.Model.Response
  alias __MODULE__
  @derive [Poison.Encoder]
  defstruct [
    :response
  ]

  @type t :: %__MODULE__{
               response: Response | nil
             }
end

defimpl Poison.Decoder, for: ResponseOk do
  import RasaNLG.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:Response, :struct, Response, options)
  end
end

