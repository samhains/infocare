defmodule InfoCare.Api do
  require IEx
  require Logger

  alias InfoCare.Config
  import HTTPoison

  @endpoint "http://infocare.digiweb.net.nz/charley/servlet/KindyNowServlet?mode="

  def get_services do
    "getServices"
    |> build_url
    |> make_post_request
  end

  def build_url url do
    @endpoint <> url
  end

  def form_body do
    { :form, [] }
  end

  def make_post_request url do
    # Is there something wrong with HTTPoison? This method runs
    # in iex, but not when I try and run the job. says it doesnt exist?
    case HTTPoison.post(url, form_body) do
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
