defmodule RasaNLG.Model.SlotValue do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    
  ]

  @type t :: %__MODULE__{
    
  }
end

defimpl Poison.Decoder, for: RasaNLG.Model.SlotValue do
  def decode(value, _options) do
    value
  end
end

