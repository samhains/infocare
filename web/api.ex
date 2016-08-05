defmodule InfoCare.QkApi do
  require IEx
  require Logger

  alias InfoCare.Config
  import HTTPoison
 

  @endpoint "https://www.qkenhanced.com.au/Enhanced.KindyNow/v1"

  def get_bookings_for_service service, start_date, end_date do
    url = @endpoint <> "/Bookings/GetAll?source=update&serviceIds="<> service.qk_service_id<>"&databaseId=5012&startDate="<>start_date<>"&endDate="<>end_date
    make_get_request url
  end

  def get_families page do
    skip =
      page*100
      |> to_string

    url = @endpoint <> "/odata/Families?$expand=Contacts,Children&$skip="<>skip
    make_get_request url
  end

  def get_services do
    url = @endpoint <> "/odata/Services?$expand=Rolls"


    make_get_request url
  end

  def make_get_request url do
    # Is there something wrong with HTTPoison? This method runs
    # in iex, but not when I try and run the job. says it doesnt exist?
    case HTTPoison.get(url, Config.auth_headers) do
      {:ok, response} ->
        case Poison.decode(response.body) do
          {:ok, data} ->
            {:ok, data}
          {:error, error} ->
            Logger.error("Problem decoding JSON from GET request to "<>url)
            Logger.error(inspect error)
            {:error, error}
        end
      {:error, error} ->
        Logger.error("Problem making the HTTP GET request to "<>url)
        Logger.error(inspect error)
        {:error, error}
    end
  end
end
