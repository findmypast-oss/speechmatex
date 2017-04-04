defmodule Speechmatex do
  @moduledoc """
  API routes that are specific to the Speechmatics API itself.
  """

  @doc """
  Get the service status of the Speechmatics API.
  """
  @spec service_status() :: {:ok, map()}
  def service_status() do
    service_status =
      "/status"
      |> Speechmatics.get!
      |> Map.get(:body)
      |> Poison.decode!

    {:ok, service_status}
  end
end
