defmodule Condorest.Web.LotController do
  use Condorest.Web, :controller
  alias Condorest.Entity
  plug :load_select_lists when action in [:new, :create, :edit, :update]

  def index(conn, _params) do
    lots = Entity.list_lots()
    render(conn, "index.html", lots: lots)
  end

  def new(conn, _params) do
    changeset = Entity.change_lot(%Condorest.Entity.Lot{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"lot" => lot_params}) do
    case Entity.create_lot(lot_params) do
      {:ok, lot} ->
        conn
        |> put_flash(:info, "Lot created successfully.")
        |> redirect(to: lot_path(conn, :show, lot))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    lot = Entity.get_lot!(id)
    fees = Condorest.Revenue.list_fees_for(lot)
    render(conn, "show.html", lot: lot, fees: fees)
  end

  def edit(conn, %{"id" => id}) do
    lot = Entity.get_lot!(id)
    changeset = Entity.change_lot(lot)
    render(conn, "edit.html", lot: lot, changeset: changeset)
  end

  def update(conn, %{"id" => id, "lot" => lot_params}) do
    lot = Entity.get_lot!(id)

    case Entity.update_lot(lot, lot_params) do
      {:ok, lot} ->
        conn
        |> put_flash(:info, "Lot updated successfully.")
        |> redirect(to: lot_path(conn, :show, lot))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", lot: lot, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    lot = Entity.get_lot!(id)
    
    case Entity.delete_lot(lot) do
      {:ok, _lot} ->
        conn
        |> put_flash(:info, "Lot deleted successfully.")
        |> redirect(to: lot_path(conn, :index))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Could not delete lot.")
        |> redirect(to: lot_path(conn, :index))
    end
  end

  defp load_select_lists(conn, _) do
    contacts = Entity.list_contacts_for_select()
    lot_types = Entity.list_lot_types_for_select()

    conn
    |> assign(:contacts, contacts)
    |> assign(:lot_types, lot_types)
  end
end
