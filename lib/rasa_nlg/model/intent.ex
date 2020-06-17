defmodule RasaNLG.Model.Intent do
  @moduledoc """
  Intent of the text
  """

  @derive [Poison.Encoder]
  defstruct [
    :confidence,
    :name
  ]

  @type t :: %__MODULE__{
    confidence: float(),
    name: String.t
  }
end

defimpl Poison.Decoder, for: RasaNLG.Model.Intent do
  def decode(value, _options) do
    value
  end
end

