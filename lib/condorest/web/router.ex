defmodule Condorest.Web.Router do
  use Condorest.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Condorest.Auth, repo: Condorest.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Condorest.Web do
    pipe_through :browser # Use the default browser stack

    resources "/users", UserController
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Condorest.Web do
  #   pipe_through :api
  # end
end
