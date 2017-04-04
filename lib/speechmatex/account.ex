defmodule Speechmatex.Account do

  @customer_id Application.get_env(:speechmatex, :customer_id)

  def details() do
    response_body =
      "/user/#{@customer_id}/"
      |> Speechmatics.get!
      |> Map.get(:body)
      |> Poison.decode!

    {:ok, %{id: response_body["user"]["id"],
            email: response_body["user"]["email"],
            balance: response_body["user"]["balance"]}}
  end

  def payments() do
    response_body =
      "/user/#{@customer_id}/payments/"
      |> Speechmatics.get!
      |> Map.get(:body)
      |> Poison.decode!

    payments =
      response_body
      |> Map.get("payments")
      |> Enum.map(&payments_key_strings_to_atoms/1)

    {:ok, payments}
  end

  defp payments_key_strings_to_atoms(%{"balance" => balance,
                                       "created_at" => created_at,
                                       "description" => description}) do
    %{balance: balance, created_at: created_at, description: description}
  end
end
