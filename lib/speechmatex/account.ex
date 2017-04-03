defmodule Speechmatex.Account do

  @customer_id Application.get_env(:speechmatex, :customer_id)

  def details() do

    response_body = "/user/#{@customer_id}/"
    |> Speechmatics.get!()
    |> Map.get(:body)
    |> Poison.decode!()

    {:ok, %{id: response_body["user"]["id"],
            email: response_body["user"]["email"],
            balance: response_body["user"]["balance"]}}
  end
end
