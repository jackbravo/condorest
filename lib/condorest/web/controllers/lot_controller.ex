defmodule Condorest.Web.LotController do
  use Condorest.Web, :controller

  alias Condorest.Lots

  def index(conn, _params) do
    lots = Lots.list_lots()
    render(conn, "index.html", lots: lots)
  end

  def new(conn, _params) do
    changeset = Lots.change_lot(%Condorest.Lots.Lot{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"lot" => lot_params}) do
    case Lots.create_lot(lot_params) do
      {:ok, lot} ->
        conn
        |> put_flash(:info, "Lot created successfully.")
        |> redirect(to: lot_path(conn, :show, lot))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    lot = Lots.get_lot!(id)
    render(conn, "show.html", lot: lot)
  end

  def edit(conn, %{"id" => id}) do
    lot = Lots.get_lot!(id)
    changeset = Lots.change_lot(lot)
    render(conn, "edit.html", lot: lot, changeset: changeset)
  end

  def update(conn, %{"id" => id, "lot" => lot_params}) do
    lot = Lots.get_lot!(id)

    case Lots.update_lot(lot, lot_params) do
      {:ok, lot} ->
        conn
        |> put_flash(:info, "Lot updated successfully.")
        |> redirect(to: lot_path(conn, :show, lot))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", lot: lot, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    lot = Lots.get_lot!(id)
    {:ok, _lot} = Lots.delete_lot(lot)

    conn
    |> put_flash(:info, "Lot deleted successfully.")
    |> redirect(to: lot_path(conn, :index))
  end
end
