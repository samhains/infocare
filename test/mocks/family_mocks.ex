defmodule InfoCare.FamilyMocks do
  def update_response_body do
    %HTTPoison.Response{status_code: 200, body: valid_response_body}
  end

  def valid_response do
    %HTTPoison.Response{status_code: 200, body: valid_response_body}
  end

  def valid_response_body do
    ~s()
  end

  def update_response do
    response_body = ~s()
    %HTTPoison.Response{status_code: 200, body: response_body}
  end
end
