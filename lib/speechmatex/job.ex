defmodule Speechmatex.Job do
  @moduledoc """
  API routes related to an account's jobs.
  """

  @customer_id Application.get_env(:speechmatex, :customer_id)

  @doc """
  Route to send an audio file off for transcription.
  """
  @spec send_for_transcription(String.t, String.t) :: {:ok, map()}
  def send_for_transcription(file_location, language) do
    multipart_form = multipart_form_for_file_upload(file_location, language)
    options = [recv_timeout: 100000, timeout: 100000]

    response_body =
      "/user/#{@customer_id}/jobs/"
      |> Speechmatics.post!(multipart_form, [], options)
      |> Map.get(:body)
      |> Poison.decode!

    {:ok, response_body}
  end

  @doc """
  Route to check the statuses of all jobs for an account.
  """
  @spec check_statuses() :: {:ok, map()}
  def check_statuses() do
    response_body =
      "/user/#{@customer_id}/jobs/"
      |> Speechmatics.get!
      |> Map.get(:body)
      |> Poison.decode!
      |> Map.get("jobs")

    {:ok, response_body}
  end

  @doc """
  Route to check the status of a particular job.
  """
  @spec check_status(integer()) :: {:ok, map()}
  def check_status(job_id) do
    response_body =
      "/user/#{@customer_id}/jobs/#{job_id}/"
      |> Speechmatics.get!
      |> Map.get(:body)
      |> Poison.decode!
      |> Map.get("job")

    {:ok, response_body}
  end

  @doc """
  Route to get the transcription of a completed job.
  """
  @spec get_transcription(integer()) :: {:ok, map()}
  def get_transcription(job_id) do
    response_body =
      "/user/#{@customer_id}/jobs/#{job_id}/transcript"
      |> Speechmatics.get!
      |> Map.get(:body)
      |> Poison.decode!

    {:ok, response_body}
  end

  defp multipart_form_for_file_upload(file, language) do
    filename = Path.basename(file)

    {:multipart,
      [
        {:file,
         "#{file}",
         {["form-data"], [name: "\"data_file\"", filename: "\"#{filename}\""]},
         []
        },
        {"model", language}
      ]
    }
  end
end
