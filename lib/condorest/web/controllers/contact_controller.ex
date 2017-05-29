defmodule Condorest.Web.ContactController do
  use Condorest.Web, :controller
  alias Condorest.Entity
  plug :load_lots when action in [:new, :create, :edit, :update]

  def index(conn, _params) do
    contacts = Entity.list_contacts()
    render(conn, "index.html", contacts: contacts)
  end

  def new(conn, _params) do
    changeset = Entity.change_contact(%Condorest.Entity.Contact{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"contact" => contact_params}) do
    case Entity.create_contact(contact_params) do
      {:ok, contact} ->
        conn
        |> put_flash(:info, "Contact created successfully.")
        |> redirect(to: contact_path(conn, :show, contact))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    contact = Entity.get_contact!(id)
    render(conn, "show.html", contact: contact)
  end

  def edit(conn, %{"id" => id}) do
    contact = Entity.get_contact!(id)
    changeset = Entity.change_contact(contact)
    render(conn, "edit.html", contact: contact, changeset: changeset)
  end

  def update(conn, %{"id" => id, "contact" => contact_params}) do
    contact = Entity.get_contact!(id)

    case Entity.update_contact(contact, contact_params) do
      {:ok, contact} ->
        conn
        |> put_flash(:info, "Contact updated successfully.")
        |> redirect(to: contact_path(conn, :show, contact))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", contact: contact, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    contact = Entity.get_contact!(id)
    {:ok, _contact} = Entity.delete_contact(contact)

    conn
    |> put_flash(:info, "Contact deleted successfully.")
    |> redirect(to: contact_path(conn, :index))
  end

  defp load_lots(conn, _) do
    lots = Entity.list_lots_for_select()
    assign(conn, :lots, lots)
  end
end
