defmodule Condorest.Web.ContactController do
  use Condorest.Web, :controller

  alias Condorest.Lots

  def index(conn, _params) do
    contacts = Lots.list_contacts()
    render(conn, "index.html", contacts: contacts)
  end

  def new(conn, _params) do
    changeset = Lots.change_contact(%Condorest.Lots.Contact{})
    lots = Lots.list_lots_for_select()
    render(conn, "new.html", changeset: changeset, lots: lots)
  end

  def create(conn, %{"contact" => contact_params}) do
    case Lots.create_contact(contact_params) do
      {:ok, contact} ->
        conn
        |> put_flash(:info, "Contact created successfully.")
        |> redirect(to: contact_path(conn, :show, contact))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    contact = Lots.get_contact!(id)
    render(conn, "show.html", contact: contact)
  end

  def edit(conn, %{"id" => id}) do
    contact = Lots.get_contact!(id)
    lots = Lots.list_lots_for_select()
    changeset = Lots.change_contact(contact)
    render(conn, "edit.html", contact: contact, changeset: changeset, lots: lots)
  end

  def update(conn, %{"id" => id, "contact" => contact_params}) do
    contact = Lots.get_contact!(id)

    case Lots.update_contact(contact, contact_params) do
      {:ok, contact} ->
        conn
        |> put_flash(:info, "Contact updated successfully.")
        |> redirect(to: contact_path(conn, :show, contact))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", contact: contact, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    contact = Lots.get_contact!(id)
    {:ok, _contact} = Lots.delete_contact(contact)

    conn
    |> put_flash(:info, "Contact deleted successfully.")
    |> redirect(to: contact_path(conn, :index))
  end
end
