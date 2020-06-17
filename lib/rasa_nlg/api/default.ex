defmodule RasaNLG.Api.Default do
  @moduledoc """
  API calls for all endpoints tagged `Default`.
  """

  alias RasaNLG.Connection
  import RasaNLG.RequestBuilder


  @doc """
  Core request to execute a custom action
  Rasa Core sends a request to the action server to execute a certain custom action. As a response to the action call from Core, you can modify the tracker, e.g. by setting slots and send responses back to the user.

  ## Parameters

  - connection (RasaNLG.Connection): Connection to server
  - request (Request): Describes the action to be called and provides information on the current state of the conversation.
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %RasaNLG.Model.ResponseOk{}} on success
  {:error, info} on failure
  """
  @spec call_action(Tesla.Env.client, RasaNLG.Model.Request.t, keyword()) :: {:ok, RasaNLG.Model.ResponseOk.t} | {:error, Tesla.Env.t}
  def call_action(connection, request, _opts \\ []) do
    %{}
    |> method(:post)
    |> url("/")
    |> add_param(:body, :body, request)
    |> Enum.into([])
    |> (&Connection.request(connection, &1)).()
    |> evaluate_response([
      { 200, %RasaNLG.Model.ResponseOk{}},
      { 400, %RasaNLG.Model.ResponseRejected{}},
      { 500, false}
    ])
  end
end
