defmodule InfoCare.ParentMocks do
  def update_response_body do
    %HTTPoison.Response{status_code: 200, body: valid_response_body}
  end

  def valid_response do
    %HTTPoison.Response{status_code: 200, body: valid_response_body}
  end

  def valid_response_body do
    ~s(
      {
      "Status": "OK",
      "Parents": [{
        "ParentID": "2a8a0c03-8a75-464a-8ed1-aefd87284e7c",
        "FirstName": "John",
        "LastName": "Doe",
        "Children": [
          {
            "ChildID": "e26821a7-887a-4272-b2b6-fbea566fb803",
            "ServiceID": "0322c866-862f-4cdf-a4aa-8113161825ce",
            "FirstName": "Jane",
            "LastName": "Doe",
            "DOB": "2009-08-21"
          },
          {
            "ChildID": "e26821a7-887a-4272-b2b6-fbea566fb805",
            "ServiceID": "0322c866-862f-4cdf-a4aa-811316182lcf",
            "FirstName": "Jim",
            "LastName": "Doe",
            "DOB": "2009-08-21"
          },
        ]
    },
    {
      "ParentID": "2a8a0c03-8a75-464a-8ed1-aefd87284e7d",
      "FirstName": "Sally",
      "LastName": "Marks",
      "Children": [
        {
          "ChildID": "e26821a7-887a-4272-b2b6-fbea566fb805",
          "ServiceID": "0322c866-862f-4cdf-a4aa-8113161825ce",
          "FirstName": "Jane",
          "LastName": "Marks",
          "DOB": "2009-08-1"
        }
      ]
    }]
      }
    )
  end

  def update_response do
    response_body = ~s()
    %HTTPoison.Response{status_code: 200, body: response_body}
  end
end
