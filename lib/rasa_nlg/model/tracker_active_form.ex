defmodule RasaNLG.Model.TrackerActiveForm do
  @moduledoc """
  Name of the active form
  """

  @derive [Poison.Encoder]
  defstruct [
    :name,
    :validate
  ]

  @type t :: %__MODULE__{
    name: String.t | nil,
    validate: boolean() | nil
  }
end

defimpl Poison.Decoder, for: RasaNLG.Model.TrackerActiveForm do
  def decode(value, _options) do
    value
  end
end

