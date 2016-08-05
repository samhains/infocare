defmodule InfoCare.Router do
  use InfoCare.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]

  end

  scope "/api", InfoCare do
    pipe_through :api

    scope "/v1" do
      resources "/services", ServiceController, only: [:index]
      resources "/bookings", BookingController, only: [:index]
    end
  end

  scope "/", InfoCare do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", InfoCare do
  #   pipe_through :api
  # end
end
