defmodule Condorest.Web.LotControllerTest do
  use Condorest.Web.ConnCase

  alias Condorest.Lots

  @create_attrs %{address: "some address", code: "some code"}
  @update_attrs %{address: "some updated address", code: "some updated code"}
  @invalid_attrs %{address: nil, code: nil}

  def fixture(:lot) do
    {:ok, lot} = Lots.create_lot(@create_attrs)
    lot
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, lot_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Lots"
  end

  test "renders form for new lots", %{conn: conn} do
    conn = get conn, lot_path(conn, :new)
    assert html_response(conn, 200) =~ "New Lot"
  end

  test "creates lot and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, lot_path(conn, :create), lot: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == lot_path(conn, :show, id)

    conn = get conn, lot_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Lot"
  end

  test "does not create lot and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, lot_path(conn, :create), lot: @invalid_attrs
    assert html_response(conn, 200) =~ "New Lot"
  end

  test "renders form for editing chosen lot", %{conn: conn} do
    lot = fixture(:lot)
    conn = get conn, lot_path(conn, :edit, lot)
    assert html_response(conn, 200) =~ "Edit Lot"
  end

  test "updates chosen lot and redirects when data is valid", %{conn: conn} do
    lot = fixture(:lot)
    conn = put conn, lot_path(conn, :update, lot), lot: @update_attrs
    assert redirected_to(conn) == lot_path(conn, :show, lot)

    conn = get conn, lot_path(conn, :show, lot)
    assert html_response(conn, 200) =~ "some updated address"
  end

  test "does not update chosen lot and renders errors when data is invalid", %{conn: conn} do
    lot = fixture(:lot)
    conn = put conn, lot_path(conn, :update, lot), lot: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Lot"
  end

  test "deletes chosen lot", %{conn: conn} do
    lot = fixture(:lot)
    conn = delete conn, lot_path(conn, :delete, lot)
    assert redirected_to(conn) == lot_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, lot_path(conn, :show, lot)
    end
  end
end
