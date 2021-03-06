defmodule Condorest.Web.ReceiptController do
  use Condorest.Web, :controller

  alias Condorest.Revenue
  alias Condorest.Revenue.{ Receipt, FeeLine }

  def index(conn, _params) do
    receipts = Revenue.list_receipts()
    render(conn, "index.html", receipts: receipts)
  end

  def new(conn, _params) do
    changeset = Revenue.change_receipt(%Receipt{fee_lines: [%FeeLine{}]})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"receipt" => receipt_params}) do
    case Revenue.insert_or_update_receipt_with_entry(%Receipt{}, receipt_params) do
      {:ok, %{receipt: receipt}} ->
        conn
        |> put_flash(:info, "Receipt created successfully.")
        |> redirect(to: receipt_path(conn, :show, receipt))
      {:error, :receipt, %Ecto.Changeset{} = changeset, _} ->
        # For some reason changeset doesn't have :action set (maybe Ecto.Multi.run error?)
        render(conn, "new.html", changeset: %{changeset | action: :invalid})
    end
  end

  def show(conn, %{"id" => id}) do
    receipt = Revenue.get_receipt!(id)
    render(conn, "show.html", receipt: receipt)
  end

  def edit(conn, %{"id" => id}) do
    receipt = Revenue.get_receipt!(id)
    changeset = Revenue.change_receipt(receipt)
    render(conn, "edit.html", receipt: receipt, changeset: changeset)
  end

  def update(conn, %{"id" => id, "receipt" => receipt_params}) do
    receipt = Revenue.get_receipt!(id)

    case Revenue.insert_or_update_receipt_with_entry(receipt, receipt_params) do
      {:ok, %{receipt: receipt}} ->
        conn
        |> put_flash(:info, "Receipt updated successfully.")
        |> redirect(to: receipt_path(conn, :show, receipt))
      {:error, :receipt, %Ecto.Changeset{} = changeset, _} ->
        render(conn, "edit.html", receipt: receipt, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    receipt = Revenue.get_receipt!(id)
    {:ok, _receipt} = Revenue.delete_receipt(receipt)

    conn
    |> put_flash(:info, "Receipt deleted successfully.")
    |> redirect(to: receipt_path(conn, :index))
  end
end
