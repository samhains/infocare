defmodule InfoCare.SharedMocks do
  def empty_response do
    response_body = ~s(
      {
        "@odata.context": "https://www.qkenhanced.com.au/enhanced.kindynow/v1/odata/$metadata#Services",
        "value": []
      }
    )
    %HTTPoison.Response{status_code: 200, body: response_body}
  end

  def invalid_response do
    response_body = ~s(
      {
        "error": {
          "code": "",
          "message": "Authorization has been denied for this request."
        }
      }
    )
    %HTTPoison.Response{status_code: 200, body: response_body}
  end
end
