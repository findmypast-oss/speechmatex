defmodule Speechmatex.Account do
  @moduledoc """
  Routes specific to a particular account.
  """

  @customer_id Application.get_env(:speechmatex, :customer_id)

  @doc """
  Get the details of an account.
  """
  @spec details() :: {:ok, map()}
  def details() do
    response_body =
      "/user/#{@customer_id}/"
      |> Speechmatics.get!
      |> Map.get(:body)
      |> Poison.decode!
      |> Map.get("user")

    {:ok, response_body}
  end

  @doc """
  Get payment history for an account.
  """
  @spec payments() :: {:ok, map()}
  def payments() do
    response_body =
      "/user/#{@customer_id}/payments/"
      |> Speechmatics.get!
      |> Map.get(:body)
      |> Poison.decode!
      |> Map.get("payments")

    {:ok, response_body}
  end
end
