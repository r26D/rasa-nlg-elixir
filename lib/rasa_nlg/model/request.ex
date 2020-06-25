defmodule RasaNLG.Model.Request do
  @moduledoc """
  Describes the action to be called and provides information on the current state of the conversation.
  """
  alias RasaNLG.Model.{
    Argument,
    Channel,
    Tracker
    }
  @derive [Poison.Encoder]
  defstruct [
    :arguments,
    :channel,
    :template,
    :tracker
  ]

  @type t :: %__MODULE__{
               arguments: [Argument] | nil,
               channel: Channel | nil,
               template: String.t | nil,
               tracker: Tracker | nil
             }
end

defimpl Poison.Decoder, for: RasaNLG.Model.Request do
  import RasaNLG.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:channel, :struct, RasaNLG.Model.Channel, options)
    |> deserialize(:tracker, :struct, RasaNLG.Model.Tracker, options)
  end
end

#   |> deserialize(:arguments, :list, RasaNLG.Model.Argument, options)