defmodule Speechmatex.JobTest do
  use ExUnit.Case, async: false

  alias Speechmatex.Job

  setup_all do
    :meck.new(Speechmatics)
    on_exit fn -> :meck.unload end
    :ok
  end

  test "submit a job for transcription" do
    job_details = %{balance: 1984, check_wait: 30, cost: 20, id: 2307484}
    expected = {:ok, job_details}

    stub = fn("/user/11027/jobs/", _multipart_form, _headers, _options) ->
      %HTTPoison.Response{status_code: 200, body: Poison.encode!(job_details)}
    end
    :meck.expect(Speechmatics, :post!, stub)

    actual = Job.send_for_transcription("/home/developer/talking.mp3", "en-GB")

    assert expected == actual
  end

  test "check status of all jobs for an account" do
    jobs = [%{check_wait: nil,
              created_at: "Tue, 04 Apr 2017 10:23:55 GMT",
              duration: 32,
              id: 2292034,
              job_status: "done",
              job_type: "transcription",
              lang: "en-GB",
              meta: nil,
              name: "me_doing_lots_of_talking.mp3",
              next_check: 0,
              notification: "email",
              transcription: "me_doing_lots_of_talking.json",
              url: "/v1.0/user/19057/jobs/2292034/audio",
              user_id: 11027},
            %{check_wait: nil,
              created_at: "Tue, 04 Apr 2017 09:48:57 GMT",
              duration: 32,
              id: 2291894,
              job_status: "done",
              job_type: "transcription",
              lang: "en-GB",
              meta: nil,
              name: "me_doing_lots_of_talking_2.mp3",
              next_check: 0,
              notification: "email",
              transcription: "me_doing_lots_of_talking_2.json",
              url: "/v1.0/user/19057/jobs/2291894/audio",
              user_id: 19057}]

    expected = {:ok, jobs}

    stub = fn("/user/11027/jobs/") ->
      %HTTPoison.Response{status_code: 200, body: Poison.encode!(%{jobs: jobs})}
    end
    :meck.expect(Speechmatics, :get!, stub)

    actual = Job.check_statuses()

    assert expected == actual
  end

  test "check status of a transcription" do
    job_status = %{check_wait: nil,
                   created_at: "Tue, 04 Apr 2017 09:48:57 GMT",
                   duration: 32,
                   id: 2291894,
                   job_status: "done",
                   job_type: "transcription",
                   lang: "en-GB",
                   meta: nil,
                   name: "talking.mp3",
                   next_check: 0,
                   notification: "email",
                   transcription: "talking.json",
                   url: "/v1.0/user/11027/jobs/2291894/audio",
                   user_id: 11027}
    expected = {:ok, job_status}

    stub = fn("/user/11027/jobs/2291894/") ->
      %HTTPoison.Response{status_code: 200,
                          body: Poison.encode!(%{job: job_status})}
    end
    :meck.expect(Speechmatics, :get!, stub)

    actual = Job.check_status(2291894)

    assert expected == actual
  end
end
