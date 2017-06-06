defmodule Condorest.RevenueTest do
  use Condorest.DataCase

  alias Condorest.Revenue

  describe "receipts" do
    alias Condorest.Revenue.Receipt

    @valid_attrs %{date: ~D[2010-04-17], details: "some details", number: "some number", total_amount: "120.5"}
    @update_attrs %{date: ~D[2011-05-18], details: "some updated details", number: "some updated number", total_amount: "456.7"}
    @invalid_attrs %{date: nil, details: nil, number: nil, total_amount: nil}

    def receipt_fixture(attrs \\ %{}) do
      {:ok, receipt} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Revenue.create_receipt()

      receipt
    end

    test "list_receipts/0 returns all receipts" do
      receipt = receipt_fixture()
      assert Revenue.list_receipts() == [receipt]
    end

    test "get_receipt!/1 returns the receipt with given id" do
      receipt = receipt_fixture()
      assert Revenue.get_receipt!(receipt.id) == receipt
    end

    test "create_receipt/1 with valid data creates a receipt" do
      assert {:ok, %Receipt{} = receipt} = Revenue.create_receipt(@valid_attrs)
      assert receipt.date == ~D[2010-04-17]
      assert receipt.details == "some details"
      assert receipt.number == "some number"
      assert receipt.total_amount == Decimal.new("120.5")
    end

    test "create_receipt/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Revenue.create_receipt(@invalid_attrs)
    end

    test "update_receipt/2 with valid data updates the receipt" do
      receipt = receipt_fixture()
      assert {:ok, receipt} = Revenue.update_receipt(receipt, @update_attrs)
      assert %Receipt{} = receipt
      assert receipt.date == ~D[2011-05-18]
      assert receipt.details == "some updated details"
      assert receipt.number == "some updated number"
      assert receipt.total_amount == Decimal.new("456.7")
    end

    test "update_receipt/2 with invalid data returns error changeset" do
      receipt = receipt_fixture()
      assert {:error, %Ecto.Changeset{}} = Revenue.update_receipt(receipt, @invalid_attrs)
      assert receipt == Revenue.get_receipt!(receipt.id)
    end

    test "delete_receipt/1 deletes the receipt" do
      receipt = receipt_fixture()
      assert {:ok, %Receipt{}} = Revenue.delete_receipt(receipt)
      assert_raise Ecto.NoResultsError, fn -> Revenue.get_receipt!(receipt.id) end
    end

    test "change_receipt/1 returns a receipt changeset" do
      receipt = receipt_fixture()
      assert %Ecto.Changeset{} = Revenue.change_receipt(receipt)
    end
  end
end
