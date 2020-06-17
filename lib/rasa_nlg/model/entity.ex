defmodule RasaNLG.Model.Entity do
  @moduledoc """
  Entities within a message
  """

  @derive [Poison.Encoder]
  defstruct [
    :start,
    :end,
    :value,
    :entity,
    :confidence,
    :role,
    :group
  ]

  @type t :: %__MODULE__{
    start: integer(),
    end: integer(),
    value: String.t,
    entity: String.t,
    confidence: float() | nil,
    role: String.t | nil,
    group: String.t | nil
  }
end

defimpl Poison.Decoder, for: RasaNLG.Model.Entity do
  def decode(value, _options) do
    value
  end
end

