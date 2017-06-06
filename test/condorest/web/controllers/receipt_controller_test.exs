defmodule Condorest.Web.ReceiptControllerTest do
  use Condorest.Web.ConnCase

  alias Condorest.Revenue

  @create_attrs %{date: ~D[2010-04-17], details: "some details", number: "some number", total_amount: "120.5"}
  @update_attrs %{date: ~D[2011-05-18], details: "some updated details", number: "some updated number", total_amount: "456.7"}
  @invalid_attrs %{date: nil, details: nil, number: nil, total_amount: nil}

  def fixture(:receipt) do
    {:ok, receipt} = Revenue.create_receipt(@create_attrs)
    receipt
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, receipt_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Receipts"
  end

  test "renders form for new receipts", %{conn: conn} do
    conn = get conn, receipt_path(conn, :new)
    assert html_response(conn, 200) =~ "New Receipt"
  end

  test "creates receipt and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, receipt_path(conn, :create), receipt: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == receipt_path(conn, :show, id)

    conn = get conn, receipt_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Receipt"
  end

  test "does not create receipt and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, receipt_path(conn, :create), receipt: @invalid_attrs
    assert html_response(conn, 200) =~ "New Receipt"
  end

  test "renders form for editing chosen receipt", %{conn: conn} do
    receipt = fixture(:receipt)
    conn = get conn, receipt_path(conn, :edit, receipt)
    assert html_response(conn, 200) =~ "Edit Receipt"
  end

  test "updates chosen receipt and redirects when data is valid", %{conn: conn} do
    receipt = fixture(:receipt)
    conn = put conn, receipt_path(conn, :update, receipt), receipt: @update_attrs
    assert redirected_to(conn) == receipt_path(conn, :show, receipt)

    conn = get conn, receipt_path(conn, :show, receipt)
    assert html_response(conn, 200) =~ "some updated details"
  end

  test "does not update chosen receipt and renders errors when data is invalid", %{conn: conn} do
    receipt = fixture(:receipt)
    conn = put conn, receipt_path(conn, :update, receipt), receipt: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Receipt"
  end

  test "deletes chosen receipt", %{conn: conn} do
    receipt = fixture(:receipt)
    conn = delete conn, receipt_path(conn, :delete, receipt)
    assert redirected_to(conn) == receipt_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, receipt_path(conn, :show, receipt)
    end
  end
end
