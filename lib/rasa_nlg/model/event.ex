defmodule RasaNLG.Model.Event do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :event,
    :timestamp
  ]

  @type t :: %__MODULE__{
    event: String.t,
    timestamp: integer() | nil
  }
end

defimpl Poison.Decoder, for: RasaNLG.Model.Event do
  def decode(value, _options) do
    value
  end
end

