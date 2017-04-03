defmodule Speechmatics do

  use HTTPoison.Base

  @api_v1_base_url "https://api.speechmatics.com/v1.0"

  def process_url(url) do
    auth_token = Application.get_env(:speechmatex, :auth_token)

    "#{@api_v1_base_url}#{url}?auth_token=#{auth_token}"
  end

end
