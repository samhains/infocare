defmodule InfoCare.ServiceMocks do
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

  def less_rooms_response do
    response_body = ~s(
        {
          "@odata.context": "https://www.qkenhanced.com.au/enhanced.kindynow/v1/odata/$metadata#Services",
          "value":
            [
              {
                "ServiceId": 317877,
                "DatabaseId": 5012,
                "Name": "Kindy Patch Cuddly Bear Queanbeyan",
                "Status": "Open",
                "Email": "queanbeyan@kindypatch.com.au",
                "PhoneNumber": "0262997572",
                "LicensedPlaces": 100,
                "StreetAddress": {
                  "Building": null,
                  "Street": "275 Crawford St",
                  "Suburb": "Queanbeyan",
                  "State": "VIC",
                  "Postcode": "2620"
                },
                "Rolls": [
                  {
                    "RollId": 319132,
                    "DatabaseId": 5012,
                    "Name": "POOH BEARS- TINY TOTS",
                    "MinimumAge": 12,
                    "MaximumAge": 24,
                    "Active": true
                  },
                  {
                    "RollId": 319151,
                    "DatabaseId": 5012,
                    "Name": "HUMPHREY BEARS- TODDLERS",
                    "MinimumAge": 24,
                    "MaximumAge": 36,
                    "Active": true
                  },
                  {
                    "RollId": 319166,
                    "DatabaseId": 5012,
                    "Name": "BIG BEARS - PRESCHOOL",
                    "MinimumAge": 48,
                    "MaximumAge": 60,
                    "Active": true
                  },
                  {
                    "RollId": 319167,
                    "DatabaseId": 5012,
                    "Name": "PANDA BEARS- JUNIOR PRESCHOOL",
                    "MinimumAge": 36,
                    "MaximumAge": 60,
                    "Active": true
                  }
                ]
              }
            ]
        }
    )
    %HTTPoison.Response{status_code: 200, body: response_body}
  end

  def update_response do
    response_body = ~s(
        {
          "@odata.context": "https://www.qkenhanced.com.au/enhanced.kindynow/v1/odata/$metadata#Services",
          "value":
            [
              {
                "ServiceId": 317877,
                "DatabaseId": 5012,
                "Name": "Kindy Patch Cuddly Bear Queanbeyan",
                "Status": "Open",
                "Email": "queanbeyan@kindypatch.com.au",
                "PhoneNumber": "0262997572",
                "LicensedPlaces": 100,
                "StreetAddress": {
                  "Building": null,
                  "Street": "275 Crawford St",
                  "Suburb": "Queanbeyan",
                  "State": "VIC",
                  "Postcode": "2620"
                },
                "Rolls": [
                  {
                    "RollId": 318858,
                    "DatabaseId": 5012,
                    "Name": "LITTLE PONY- NURSERY",
                    "MinimumAge": 0,
                    "MaximumAge": 24,
                    "Active": true
                  },
                  {
                    "RollId": 319132,
                    "DatabaseId": 5012,
                    "Name": "POOH BEARS- TINY TOTS",
                    "MinimumAge": 12,
                    "MaximumAge": 24,
                    "Active": true
                  },
                  {
                    "RollId": 319151,
                    "DatabaseId": 5012,
                    "Name": "HUMPHREY BEARS- TODDLERS",
                    "MinimumAge": 24,
                    "MaximumAge": 36,
                    "Active": true
                  },
                  {
                    "RollId": 319166,
                    "DatabaseId": 5012,
                    "Name": "BIG BEARS - PRESCHOOL",
                    "MinimumAge": 48,
                    "MaximumAge": 60,
                    "Active": true
                  },
                  {
                    "RollId": 319167,
                    "DatabaseId": 5012,
                    "Name": "PANDA BEARS- JUNIOR PRESCHOOL",
                    "MinimumAge": 36,
                    "MaximumAge": 60,
                    "Active": true
                  }
                ]
              }
            ]
        }
    )
    %HTTPoison.Response{status_code: 200, body: response_body}
  end

  def valid_response_body do
      ~s(
        {
          "@odata.context": "https://www.qkenhanced.com.au/enhanced.kindynow/v1/odata/$metadata#Services",
          "value":[
            {
                  "ServiceId": 317877,
                  "DatabaseId": 5012,
                  "Name": "Kindy Patch Cuddly Bear Queanbeyan",
                  "Status": "Open",
                  "Email": "queanbeyan@kindypatch.com.au",
                  "PhoneNumber": "0262997572",
                  "LicensedPlaces": 76,
                  "StreetAddress": {
                    "Building": null,
                    "Street": "275 Crawford St",
                    "Suburb": "Queanbeyan",
                    "State": "NSW",
                    "Postcode": "2620"
                  },
                  "Rolls": [
                    {
                      "RollId": 318858,
                      "DatabaseId": 5012,
                      "Name": "LITTLE BEARS- NURSERY",
                      "MinimumAge": 0,
                      "MaximumAge": 24,
                      "Active": true
                    },
                    {
                      "RollId": 319132,
                      "DatabaseId": 5012,
                      "Name": "POOH BEARS- TINY TOTS",
                      "MinimumAge": 12,
                      "MaximumAge": 24,
                      "Active": true
                    },
                    {
                      "RollId": 319151,
                      "DatabaseId": 5012,
                      "Name": "HUMPHREY BEARS- TODDLERS",
                      "MinimumAge": 24,
                      "MaximumAge": 36,
                      "Active": true
                    },
                    {
                      "RollId": 319166,
                      "DatabaseId": 5012,
                      "Name": "BIG BEARS - PRESCHOOL",
                      "MinimumAge": 48,
                      "MaximumAge": 60,
                      "Active": true
                    },
                    {
                      "RollId": 319167,
                      "DatabaseId": 5012,
                      "Name": "PANDA BEARS- JUNIOR PRESCHOOL",
                      "MinimumAge": 36,
                      "MaximumAge": 60,
                      "Active": true
                    }
                  ]
                },
                {
                  "ServiceId": 317878,
                  "DatabaseId": 5012,
                  "Name": "Penguin Childcare Melbourne",
                  "Status": "Open",
                  "Email": "melbourne@penguinchildcare.com.au",
                  "PhoneNumber": "0396003456",
                  "LicensedPlaces": 100,
                  "StreetAddress": {
                    "Building": null,
                    "Street": "Level 1 & 2 2-750 Collins Street",
                    "Suburb": "MELBOURNE",
                    "State": "VIC",
                    "Postcode": "3000"
                  },
                  "Rolls": [
                    {
                      "RollId": 319036,
                      "DatabaseId": 5012,
                      "Name": "TODDLER 2",
                      "MinimumAge": 24,
                      "MaximumAge": 36,
                      "Active": true
                    },
                    {
                      "RollId": 318892,
                      "DatabaseId": 5012,
                      "Name": "TODDLER 3",
                      "MinimumAge": 24,
                      "MaximumAge": 36,
                      "Active": true
                    },
                    {
                      "RollId": 318793,
                      "DatabaseId": 5012,
                      "Name": "NURSERY 1",
                      "MinimumAge": 0,
                      "MaximumAge": 12,
                      "Active": true
                    },
                    {
                      "RollId": 318725,
                      "DatabaseId": 5012,
                      "Name": "KINDER",
                      "MinimumAge": 48,
                      "MaximumAge": 60,
                      "Active": true
                    },
                    {
                      "RollId": 318238,
                      "DatabaseId": 5012,
                      "Name": "TODDLER 1",
                      "MinimumAge": 12,
                      "MaximumAge": 24,
                      "Active": true
                    },
                    {
                      "RollId": 318263,
                      "DatabaseId": 5012,
                      "Name": "PRE KINDER",
                      "MinimumAge": 36,
                      "MaximumAge": 48,
                      "Active": true
                    },
                    {
                      "RollId": 318496,
                      "DatabaseId": 5012,
                      "Name": "1-BYK8LB",
                      "MinimumAge": 2,
                      "MaximumAge": 5,
                      "Active": false
                    }
                  ]
                }
          ]
        }
    )
  end

  def valid_response do
    %HTTPoison.Response{status_code: 200, body: valid_response_body}
  end

end
