defmodule InfoCare.PageController do
  use InfoCare.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
