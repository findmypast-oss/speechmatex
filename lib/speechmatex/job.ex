defmodule Speechmatex.Job do

  @customer_id Application.get_env(:speechmatex, :customer_id)


  def send_for_transcription(file_location, language) do
    multipart_form = multipart_form_for_file_upload(file_location, language)
    options = [recv_timeout: 100000, timeout: 100000]

    response_body =
      "/user/#{@customer_id}/jobs/"
      |> Speechmatics.post!(multipart_form, [], options)
      |> Map.get(:body)
      |> Poison.decode!
      |> Enum.reduce(%{}, &string_keys_to_atoms/2)

    {:ok, response_body}
  end

  def check_statuses() do
    response_body =
      "/user/#{@customer_id}/jobs/"
      |> Speechmatics.get!
      |> Map.get(:body)
      |> Poison.decode!
      |> Map.get("jobs")
      |> Enum.map(fn(job) -> Enum.reduce(job, %{}, &string_keys_to_atoms/2) end)

    {:ok, response_body}
  end

  def check_status(job_id) do
    response_body =
      "/user/#{@customer_id}/jobs/#{job_id}/"
      |> Speechmatics.get!
      |> Map.get(:body)
      |> Poison.decode!
      |> Map.get("job")
      |> Enum.reduce(%{}, &string_keys_to_atoms/2)

    {:ok, response_body}
  end

  def retrieve_transcription(job_id) do

  end

  def list() do

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

  defp string_keys_to_atoms({key, value}, acc) do
    Map.put(acc, String.to_atom(key), value)
  end
end
