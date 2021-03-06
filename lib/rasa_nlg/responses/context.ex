defmodule RasaNLG.Responses.Context do
  alias RasaNLG.Model.{ParseResult, Tracker}
  alias RasaNLG.Model.{
    Request,
    Response,
    ResponseOk,
    ResponseRejected
    }


  require Logger

  defstruct [
    :request,
    :response,
    :error
  ]

  @type t :: %__MODULE__{
               request: Request.t(),
               response: ResponseOk.t(),
               error: ResponseRejected.t() | nil
             }

  def new(request) do
    %__MODULE__{
      request: request,
      response: %ResponseOk{
        response: %Response{},
      },
      error: nil
    }
  end

  @doc """
  Return the currently set values of the slots
  """
  def current_slot_values(
        %__MODULE__{
          request: %Request{
            tracker: %Tracker{
              slots: slots
            }
          }
        }
      ),
      do: slots

  @doc """
  Retrieves the value of a slot.
  """
  def get_slot(
        %__MODULE__{
          request: %Request{
            tracker: %Tracker{
              slots: slots
            }
          }
        },
        key
      ) do
    if Map.has_key?(slots, key) do
      Map.get(slots, key)
    else
      Logger.info("Tried to access non existent slot #{key}")
      nil
    end
  end



  @doc """
  Get entity values found for the passed entity name in latest msg.

  If you are only interested in the first entity of a given type use
  `get_latest_entities(tracker, "my_entity_name") |> List.first()`.
  If no entity is found `nil` is the default result.
  """
  def get_latest_entities(context, entity_type, opts \\ [])

  def get_latest_entities(
        %__MODULE__{
          request: %Request{
            tracker: %Tracker{
              latest_message: nil
            }
          }
        },
        _,
        _
      ) do
    []
  end

  def get_latest_entities(
        %__MODULE__{
          request: %Request{
            tracker: %Tracker{
              latest_message: %ParseResult{
                entities: nil
              }
            }
          }
        },
        _,
        _
      ) do
    []
  end

  def get_latest_entities(
        %__MODULE__{
          request: %Request{
            tracker: %Tracker{
              latest_message: %ParseResult{
                entities: entities
              }
            }
          }
        },
        entity_type,
        opts
      ) do
    role = Keyword.get(opts, :role)
    group = Keyword.get(opts, :group)

    entities
    # |> Enum.filter(fn e -> e.entity == entity_type end)
    |> Enum.filter(&filter_entity_by(&1, :entity, entity_type))
    |> Enum.filter(&filter_entity_by(&1, :role, role))
    |> Enum.filter(&filter_entity_by(&1, :group, group))
  end

  defp filter_entity_by(_entity, _key, nil), do: true
  defp filter_entity_by(entity, field, value), do: Map.get(entity, field) == value

  @doc """
  Get the name of the input_channel of the latest UserUttered event
  """
  def latest_input_channel(
        %__MODULE__{
          request: %Request{
            tracker: %Tracker{
              latest_input_channel: latest_input_channel
            }
          }
        }
      ) do
    latest_input_channel
  end

  def latest_event_time(
        %__MODULE__{
          request: %Request{
            tracker: %Tracker{
              latest_event_time: latest_event_time
            }
          }
        }
      ) do
    latest_event_time
  end


  def set_response(%__MODULE__{} = context, %Response{} = response) do
    Map.replace!(context, :response, %ResponseOk{
      response:  response,
    })
  end
  def set_response(%__MODULE__{} = context, %Response{} = response, nil) do
    Map.replace!(context, :response, %ResponseOk{
      response:  response,
    })
  end
  def set_response(%__MODULE__{} = context, %Response{} = response, personality) do
    Map.replace!(context, :response, %ResponseOk{
      response:  response |> personality.personalize(context),
    })
  end

  def set_error(%__MODULE__{} = context, response_name, error) do
    Map.replace!(context, :error, %ResponseRejected{response_name: response_name, error: error})
  end
end
