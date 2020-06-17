defmodule RasaNLG.Model.ParseResult do
  @moduledoc """
  NLU parser information. If set, message will not be passed through NLU, but instead this parsing information will be used.
  """
  alias RasaNLG.Model.Entity
  alias RasaNLG.Model.Intent
  alias RasaNLG.Model.Intent

  @derive [Poison.Encoder]
  defstruct [
    :entities,
    :intent,
    :intent_ranking,
    :text
  ]

  @type t :: %__MODULE__{
    entities: [Entity] | nil,
    intent: Intent | nil,
    intent_ranking: [Intent] | nil,
    text: String.t
  }
end

defimpl Poison.Decoder, for: RasaNLG.Model.ParseResult do
  import RasaNLG.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:entities, :list, RasaNLG.Model.Entity, options)
    |> deserialize(:intent, :struct, RasaNLG.Model.Intent, options)
    |> deserialize(:intent_ranking, :list, RasaNLG.Model.Intent, options)
  end
end

