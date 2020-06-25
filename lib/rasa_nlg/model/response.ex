defmodule RasaNLG.Model.Response do
  @moduledoc """
  
  """
  alias RasaNLG.Model.{
    Button,
    Attachment,
    Element
    }

    #DJE - it isn't clear if you can return multiple text and have Rasa pick
  @derive [Poison.Encoder]
  defstruct [
    :text,
    :image,
    :elements,
    :attachments,
    :buttons
  ]

  @type t :: %__MODULE__{
               text: String.t,
               image: String.t,
               elements: [Element] | nil,
               attachments: [Attachment] | nil,
               buttons: [Button] | nil
             }
end

defimpl Poison.Decoder, for: RasaNLG.Model.Response do
  import RasaNLG.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:buttons, :list, RasaNLG.Model.Button, options)
    |> deserialize(:elements, :list, RasaNLG.Model.Element, options)
    |> deserialize(:attachments, :list, RasaNLG.Model.Attachment, options)
  end
end

