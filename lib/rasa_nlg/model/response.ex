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
    |> deserialize(:buttons, :list, Button, options)
    |> deserialize(:elements, :list, Element, options)
    |> deserialize(:attachments, :list, Attachment, options)
  end
end

