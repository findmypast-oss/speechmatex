defmodule Speechmatex.AccountTest do
  use ExUnit.Case, async: false

  alias Speechmatex.Account

  setup_all do
    :meck.new(Speechmatics)
    on_exit fn -> :meck.unload end
    :ok
  end

  test "Get account details" do
    user_details = %{"balance" => 1990,
                     "email" => "test_user@test.com",
                     "id" => 11027}
    expected = {:ok, user_details}

    stub = fn("/user/11027/") ->
      %HTTPoison.Response{status_code: 200,
                          body: Poison.encode!(%{user: user_details})}
    end
    :meck.expect(Speechmatics, :get!, stub)

    actual = Account.details()

    assert expected == actual
  end

  test "Get payment history" do
    payments = [%{"balance" => -6,
                  "created_at" => "Fri, 31 Mar 2017 08:54:25 GMT",
                  "description" => "transcription of recording.mp3"},
                %{"balance" => 1000,
                  "created_at" => "Thu, 30 Mar 2017 09:54:25 GMT",
                  "description" => "Purchase of credits"}]
    expected = {:ok, payments}

    stub = fn("/user/11027/payments/") ->
      %HTTPoison.Response{status_code: 200,
                          body: Poison.encode!(%{payments: payments})}
    end
    :meck.expect(Speechmatics, :get!, stub)

    actual = Account.payments()

    assert expected == actual
  end
end
