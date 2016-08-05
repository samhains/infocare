defmodule InfoCare.FamilyMocks do
  def valid_response do
    %HTTPoison.Response{status_code: 200, body: valid_response_body}
  end

  def valid_response do
    %HTTPoison.Response{status_code: 200, body: valid_response_body}
  end

  def valid_response_body do
      ~s(
          {
            "@odata.context": "https://www.qkenhanced.com.au/enhanced.kindynow/v1/odata/$metadata#Services",
            "value":
              [
                {
                  "FamilyId": 321222,
                  "DatabaseId": 5012,
                  "Name": "HARDY, Sam",
                  "Contacts": [
                    {
                      "ContactId": 680892,
                      "DatabaseId": 5012,
                      "Title": null,
                      "GivenName": "Jeffrey Paul",
                      "Surname": "Hains",
                      "MobilePhoneNumber": "0492 287 287",
                      "AccountRelationship": null
                    },
                    {
                      "ContactId": 688748,
                      "DatabaseId": 5012,
                      "Title": null,
                      "GivenName": "Samuel",
                      "Surname": "JOMA",
                      "MobilePhoneNumber": "0433 060642",
                      "AccountRelationship": "PrimaryContact"
                    }
                  ],
                  "Children": [
                    {
                      "ChildId": 393540,
                      "DatabaseId": 5012,
                      "GivenName": "NICHOLAS",
                      "Surname": "Hains",
                      "DateOfBirth": "2007-02-24T00:00:00Z",
                      "SyncId": "09e2afcf-1471-e211-a3ad-5ef3fc0d484b"
                    }
                  ]
                },
                {
                  "FamilyId": 321223,
                  "DatabaseId": 5012,
                  "Name": "Bhatia, Sanvi",
                  "Contacts": [
                    {
                      "ContactId": 698634,
                      "DatabaseId": 5012,
                      "Title": null,
                      "GivenName": "Harneet",
                      "Surname": "Bhatia",
                      "MobilePhoneNumber": "0410031163",
                      "AccountRelationship": "PrimaryContact"
                    }
                  ],
                  "Children": [
                    {
                      "ChildId": 425245,
                      "DatabaseId": 5012,
                      "GivenName": "Sanvi",
                      "Surname": "Bhatia",
                      "DateOfBirth": "2007-11-15T00:00:00Z",
                      "SyncId": "2809bacf-1471-e211-a3ad-5ef3fc0d484b"
                    }
                  ]
                },
                {
                  "FamilyId": 321226,
                  "DatabaseId": 5012,
                  "Name": "KUT",
                  "Contacts": [
                    {
                      "ContactId": 759605,
                      "DatabaseId": 5012,
                      "Title": null,
                      "GivenName": "ARACH DENG",
                      "Surname": "KUT",
                      "MobilePhoneNumber": null,
                      "AccountRelationship": "PrimaryContact"
                    }
                  ],
                  "Children": [
                    {
                      "ChildId": 393459,
                      "DatabaseId": 5012,
                      "GivenName": "HERJOK",
                      "Surname": "KUOL",
                      "DateOfBirth": "2008-04-29T00:00:00Z",
                      "SyncId": "a9e1d6cf-1471-e211-a3ad-5ef3fc0d484b"
                    },
                    {
                      "ChildId": 419096,
                      "DatabaseId": 5012,
                      "GivenName": "GEU",
                      "Surname": "KUOL",
                      "DateOfBirth": "2009-12-15T00:00:00Z",
                      "SyncId": "5fe1d6cf-1471-e211-a3ad-5ef3fc0d484b"
                    }
                  ]
                }
              ]
          }
      )
    end

  def update_response do
    response_body = ~s(
        {
          "@odata.context": "https://www.qkenhanced.com.au/enhanced.kindynow/v1/odata/$metadata#Services",
          "value":
            [
              {
                "FamilyId": 321222,
                "DatabaseId": 5012,
                "Name": "HARDY, Sam",
                "Contacts": [
                  {
                    "ContactId": 680892,
                    "DatabaseId": 5012,
                    "Title": null,
                    "GivenName": "Jeffrey Paul",
                    "Surname": "Hains",
                    "MobilePhoneNumber": "0492 287 287",
                    "AccountRelationship": null
                  },
                  {
                    "ContactId": 688748,
                    "DatabaseId": 5012,
                    "Title": null,
                    "GivenName": "Samuel",
                    "Surname": "JOMA",
                    "MobilePhoneNumber": "0433 060642",
                    "AccountRelationship": "PrimaryContact"
                  }
                ],
                "Children": [
                  {
                    "ChildId": 393540,
                    "DatabaseId": 5012,
                    "GivenName": "NICHOLAS",
                    "Surname": "Hains",
                    "DateOfBirth": "2007-02-24T00:00:00Z",
                    "SyncId": "09e2afcf-1471-e211-a3ad-5ef3fc0d484b"
                  }
                ]
              },
              {
                "FamilyId": 321223,
                "DatabaseId": 5012,
                "Name": "Bhatia, Sanvi",
                "Contacts": [
                  {
                    "ContactId": 698634,
                    "DatabaseId": 5012,
                    "Title": null,
                    "GivenName": "Harneet",
                    "Surname": "Bhatia",
                    "MobilePhoneNumber": "0410031163",
                    "AccountRelationship": "PrimaryContact"
                  }
                ],
                "Children": [
                  {
                    "ChildId": 425245,
                    "DatabaseId": 5012,
                    "GivenName": "Sanvi",
                    "Surname": "Bhatia",
                    "DateOfBirth": "2007-11-15T00:00:00Z",
                    "SyncId": "2809bacf-1471-e211-a3ad-5ef3fc0d484b"
                  }
                ]
              },
              {
                "FamilyId": 321226,
                "DatabaseId": 5012,
                "Name": "KUT",
                "Contacts": [
                  {
                    "ContactId": 759605,
                    "DatabaseId": 5012,
                    "Title": null,
                    "GivenName": "ARACH DENG",
                    "Surname": "KUT",
                    "MobilePhoneNumber": null,
                    "AccountRelationship": "PrimaryContact"
                  }
                ],
                "Children": [
                  {
                    "ChildId": 393459,
                    "DatabaseId": 5012,
                    "GivenName": "HERJOK",
                    "Surname": "KUOL",
                    "DateOfBirth": "2008-04-29T00:00:00Z",
                    "SyncId": "a9e1d6cf-1471-e211-a3ad-5ef3fc0d484b"
                  },
                  {
                    "ChildId": 419096,
                    "DatabaseId": 5012,
                    "GivenName": "GEU",
                    "Surname": "KUOL",
                    "DateOfBirth": "2009-12-15T00:00:00Z",
                    "SyncId": "5fe1d6cf-1471-e211-a3ad-5ef3fc0d484b"
                  }
                ]
              }
            ]
        }
    )
    %HTTPoison.Response{status_code: 200, body: response_body}
  end
end
