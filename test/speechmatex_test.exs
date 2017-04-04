defmodule SpeechmatexTest do
  use ExUnit.Case, async: false

  setup_all do
    :meck.new(Speechmatics)
    on_exit fn -> :meck.unload end
    :ok
  end

  test "Get service status" do
    service_status = %{"Average_Turnaround_Mins" => 2,
                       "Known_Issues" => false,
                       "Queue_Length_Mins" => 1,
                       "Status" => "Good",
                       "Time_UTC" => "Mon, 03 Apr 2017 15:05:01 GMT"}
    expected = {:ok, service_status}

    stub = fn("/status") ->
      %HTTPoison.Response{status_code: 200,
                          body: Poison.encode!(service_status)}
    end
    :meck.expect(Speechmatics, :get!, stub)

    actual = Speechmatex.service_status()

    assert expected == actual
  end
end
