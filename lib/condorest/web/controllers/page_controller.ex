defmodule Condorest.Web.PageController do
  use Condorest.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
