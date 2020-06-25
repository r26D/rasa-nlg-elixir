defmodule RasaNLG.Model.Argument do
  @moduledoc """
  There isn't documentation for arguments
  """

  @derive [Poison.Encoder]
  defstruct [
    :payload
  ]

  @type t :: %__MODULE__{
               payload: String.t | nil
             }
end

defimpl Poison.Decoder, for: RasaNLG.Model.Argument do
  def decode(value, _options) do
    value
  end
end

