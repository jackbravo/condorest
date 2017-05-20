defmodule Condorest.Web.ContactControllerTest do
  use Condorest.Web.ConnCase

  alias Condorest.Lots

  @create_attrs %{is_owner: true, name: "some name", phonenumber: "some phonenumber"}
  @update_attrs %{is_owner: false, name: "some updated name", phonenumber: "some updated phonenumber"}
  @invalid_attrs %{is_owner: nil, name: nil, phonenumber: nil}

  def fixture(:contact) do
    {:ok, contact} = Lots.create_contact(@create_attrs)
    contact
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, contact_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Contacts"
  end

  test "renders form for new contacts", %{conn: conn} do
    conn = get conn, contact_path(conn, :new)
    assert html_response(conn, 200) =~ "New Contact"
  end

  test "creates contact and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, contact_path(conn, :create), contact: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == contact_path(conn, :show, id)

    conn = get conn, contact_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Contact"
  end

  test "does not create contact and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, contact_path(conn, :create), contact: @invalid_attrs
    assert html_response(conn, 200) =~ "New Contact"
  end

  test "renders form for editing chosen contact", %{conn: conn} do
    contact = fixture(:contact)
    conn = get conn, contact_path(conn, :edit, contact)
    assert html_response(conn, 200) =~ "Edit Contact"
  end

  test "updates chosen contact and redirects when data is valid", %{conn: conn} do
    contact = fixture(:contact)
    conn = put conn, contact_path(conn, :update, contact), contact: @update_attrs
    assert redirected_to(conn) == contact_path(conn, :show, contact)

    conn = get conn, contact_path(conn, :show, contact)
    assert html_response(conn, 200) =~ "some updated name"
  end

  test "does not update chosen contact and renders errors when data is invalid", %{conn: conn} do
    contact = fixture(:contact)
    conn = put conn, contact_path(conn, :update, contact), contact: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Contact"
  end

  test "deletes chosen contact", %{conn: conn} do
    contact = fixture(:contact)
    conn = delete conn, contact_path(conn, :delete, contact)
    assert redirected_to(conn) == contact_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, contact_path(conn, :show, contact)
    end
  end
end
