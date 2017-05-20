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

    resources "/sessions", SessionController, only: [:new, :create, :delete]
    get "/", PageController, :index
  end

  scope "/", Condorest.Web do
    pipe_through [:browser, :authenticate_user]

    resources "/users", UserController
    resources "/lots", LotController
    resources "/contacts", ContactController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Condorest.Web do
  #   pipe_through :api
  # end
end
