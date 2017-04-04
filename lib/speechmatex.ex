defmodule Speechmatex do

  def service_status() do
    service_status =
      "/status"
      |> Speechmatics.get!
      |> Map.get(:body)
      |> Poison.decode!

    {:ok, service_status}
  end

end
