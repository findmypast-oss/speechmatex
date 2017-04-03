defmodule Speechmatex do

  def service_status() do
    service_status =
      "/status"
      |> Speechmatics.get!
      |> Map.get(:body)
      |> Poison.decode!
      |> Enum.reduce(%{}, fn({k, v}, acc) ->
        Map.put(acc, String.to_atom(k), v)
      end)

    {:ok, service_status}
  end

end
