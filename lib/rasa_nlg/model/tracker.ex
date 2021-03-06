defmodule RasaNLG.Model.Tracker do
  @moduledoc """
  Conversation tracker which stores the conversation state.
  """
  alias RasaNLG.Model.{
    ParseResult,
    Event,
    TrackerActiveForm
    }



  @derive [Poison.Encoder]
  defstruct [
    :conversation_id,
    :slots,
    :latest_message,
    :latest_event_time,
    :followup_action,
    :paused,
    :events,
    :latest_input_channel,
    :latest_action_name,
    :active_form,
    :sender_id
  ]

  @type t :: %__MODULE__{
               conversation_id: String.t | nil,
               slots: [Map] | nil,
               latest_message: ParseResult | nil,
               latest_event_time: float() | nil,
               followup_action: String.t | nil,
               paused: boolean() | nil,
               events: [Event] | nil,
               latest_input_channel: String.t | nil,
               latest_action_name: String.t | nil,
               active_form: TrackerActiveForm | nil,
               sender_id: String.t | nil
             }
end

defimpl Poison.Decoder, for: RasaNLG.Model.Tracker do
  import RasaNLG.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:latest_message, :struct, RasaNLG.Model.ParseResult, options)
    |> deserialize(:events, :list, RasaNLG.Model.Event, options)
    |> deserialize(:active_form, :struct, RasaNLG.Model.TrackerActiveForm, options)
  end
end

