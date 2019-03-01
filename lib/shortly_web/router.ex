defmodule ShortlyWeb.Router do
  use ShortlyWeb, :router

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

  scope "/", ShortlyWeb do
    pipe_through :browser

    resources "/links", LinkController

    get "/", PageController, :index
    get "/:short_url", PageController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", ShortlyWeb do
  #   pipe_through :api
  # end
end
