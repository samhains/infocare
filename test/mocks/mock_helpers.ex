defmodule InfoCare.MockHelpers do
  def http_valid_response body do
    %HTTPoison.Response{status_code: 200, body: body}
  end
end
