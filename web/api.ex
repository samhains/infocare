defmodule InfoCare.Api do
  require IEx
  require Logger

  alias InfoCare.Config
  import HTTPoison

  @endpoint "http://infocare.digiweb.net.nz/charley/servlet/KindyNowServlet?mode="

  def get_services do
    "getServices"
    |> build_url
    |> make_post_request(form_body)
  end

  def get_parents_by_service service do
    service_id = service.id |> to_string
    body = ~s({"ServiceID": #{service_id}})

    "getParentsByService"
    |> build_url
    |> make_post_request(body)
  end

  def get_parents do
    "getParent"
    |> build_url
    |> make_post_request(form_body)
  end

  def build_url url do
    @endpoint <> url
  end

  def form_body do
    { :form, [] }
  end

  def form_body params do
    { :form, params }
  end

  def make_post_request url, form_body do
    # Is there something wrong with HTTPoison? This method runs
    # in iex, but not when I try and run the job. says it doesnt exist?
    case HTTPoison.post(url, form_body, Config.post_headers) do
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
        Logger.error("Problem making the HTTP POST request to "<>url)
        Logger.error(inspect error)
        {:error, error}
    end
  end
end
