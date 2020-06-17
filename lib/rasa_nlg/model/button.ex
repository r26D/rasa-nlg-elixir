defmodule RasaNLG.Model.Button do
  @moduledoc """
  A button which can be clicked by the user in the conversation.
  """

  @derive [Poison.Encoder]
  defstruct [
    :title,
    :payload
  ]

  @type t :: %__MODULE__{
    title: String.t | nil,
    payload: String.t | nil
  }
end

defimpl Poison.Decoder, for: RasaNLG.Model.Button do
  def decode(value, _options) do
    value
  end
end

