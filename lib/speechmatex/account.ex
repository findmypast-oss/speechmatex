defmodule Speechmatex.Account do

  @customer_id Application.get_env(:speechmatex, :customer_id)

  def details() do
    response_body =
      "/user/#{@customer_id}/"
      |> Speechmatics.get!
      |> Map.get(:body)
      |> Poison.decode!
      |> Map.get("user")

    {:ok, response_body}
  end

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
