defmodule Condorest.Web.LotTypeController do
  use Condorest.Web, :controller

  alias Condorest.Entity

  def index(conn, _params) do
    lot_types = Entity.list_lot_types()
    render(conn, "index.html", lot_types: lot_types)
  end

  def new(conn, _params) do
    changeset = Entity.change_lot_type(%Condorest.Entity.LotType{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"lot_type" => lot_type_params}) do
    case Entity.create_lot_type(lot_type_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Lot type created successfully.")
        |> redirect(to: lot_type_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    lot_type = Entity.get_lot_type!(id)
    changeset = Entity.change_lot_type(lot_type)
    render(conn, "edit.html", lot_type: lot_type, changeset: changeset)
  end

  def update(conn, %{"id" => id, "lot_type" => lot_type_params}) do
    lot_type = Entity.get_lot_type!(id)

    case Entity.update_lot_type(lot_type, lot_type_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Lot type updated successfully.")
        |> redirect(to: lot_type_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", lot_type: lot_type, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    lot_type = Entity.get_lot_type!(id)
    {:ok, _lot_type} = Entity.delete_lot_type(lot_type)

    conn
    |> put_flash(:info, "Lot type deleted successfully.")
    |> redirect(to: lot_type_path(conn, :index))
  end
end
