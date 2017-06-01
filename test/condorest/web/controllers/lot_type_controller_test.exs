defmodule Condorest.Web.LotTypeControllerTest do
  use Condorest.Web.ConnCase

  alias Condorest.Entity

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:lot_type) do
    {:ok, lot_type} = Entity.create_lot_type(@create_attrs)
    lot_type
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, lot_type_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Lot types"
  end

  test "renders form for new lot_types", %{conn: conn} do
    conn = get conn, lot_type_path(conn, :new)
    assert html_response(conn, 200) =~ "New Lot type"
  end

  test "creates lot_type and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, lot_type_path(conn, :create), lot_type: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == lot_type_path(conn, :show, id)

    conn = get conn, lot_type_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Lot type"
  end

  test "does not create lot_type and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, lot_type_path(conn, :create), lot_type: @invalid_attrs
    assert html_response(conn, 200) =~ "New Lot type"
  end

  test "renders form for editing chosen lot_type", %{conn: conn} do
    lot_type = fixture(:lot_type)
    conn = get conn, lot_type_path(conn, :edit, lot_type)
    assert html_response(conn, 200) =~ "Edit Lot type"
  end

  test "updates chosen lot_type and redirects when data is valid", %{conn: conn} do
    lot_type = fixture(:lot_type)
    conn = put conn, lot_type_path(conn, :update, lot_type), lot_type: @update_attrs
    assert redirected_to(conn) == lot_type_path(conn, :show, lot_type)

    conn = get conn, lot_type_path(conn, :show, lot_type)
    assert html_response(conn, 200) =~ "some updated name"
  end

  test "does not update chosen lot_type and renders errors when data is invalid", %{conn: conn} do
    lot_type = fixture(:lot_type)
    conn = put conn, lot_type_path(conn, :update, lot_type), lot_type: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Lot type"
  end

  test "deletes chosen lot_type", %{conn: conn} do
    lot_type = fixture(:lot_type)
    conn = delete conn, lot_type_path(conn, :delete, lot_type)
    assert redirected_to(conn) == lot_type_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, lot_type_path(conn, :show, lot_type)
    end
  end
end
