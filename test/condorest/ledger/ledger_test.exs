defmodule Condorest.LedgerTest do
  use Condorest.DataCase

  alias Condorest.Ledger

  describe "accounts" do
    alias Condorest.Ledger.Account

    @valid_attrs %{contra: true, name: "some name", type: "some type"}
    @update_attrs %{contra: false, name: "some updated name", type: "some updated type"}
    @invalid_attrs %{contra: nil, name: nil, type: nil}

    def account_fixture(attrs \\ %{}) do
      {:ok, account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ledger.create_account()

      account
    end

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Ledger.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Ledger.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      assert {:ok, %Account{} = account} = Ledger.create_account(@valid_attrs)
      assert account.contra == true
      assert account.name == "some name"
      assert account.type == "some type"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ledger.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      assert {:ok, account} = Ledger.update_account(account, @update_attrs)
      assert %Account{} = account
      assert account.contra == false
      assert account.name == "some updated name"
      assert account.type == "some updated type"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Ledger.update_account(account, @invalid_attrs)
      assert account == Ledger.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Ledger.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Ledger.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Ledger.change_account(account)
    end
  end

  describe "entries" do
    alias Condorest.Ledger.Entry

    @valid_attrs %{date: ~D[2010-04-17], description: "some description"}
    @update_attrs %{date: ~D[2011-05-18], description: "some updated description"}
    @invalid_attrs %{date: nil, description: nil}

    def entry_fixture(attrs \\ %{}) do
      {:ok, entry} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ledger.create_entry()

      entry
    end

    test "list_entries/0 returns all entries" do
      entry = entry_fixture()
      assert Ledger.list_entries() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = entry_fixture()
      assert Ledger.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      assert {:ok, %Entry{} = entry} = Ledger.create_entry(@valid_attrs)
      assert entry.date == ~D[2010-04-17]
      assert entry.description == "some description"
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ledger.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = entry_fixture()
      assert {:ok, entry} = Ledger.update_entry(entry, @update_attrs)
      assert %Entry{} = entry
      assert entry.date == ~D[2011-05-18]
      assert entry.description == "some updated description"
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Ledger.update_entry(entry, @invalid_attrs)
      assert entry == Ledger.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{}} = Ledger.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Ledger.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()
      assert %Ecto.Changeset{} = Ledger.change_entry(entry)
    end
  end

  describe "amounts" do
    alias Condorest.Ledger.Amount

    @valid_attrs %{amount: "120.5", type: "some type"}
    @update_attrs %{amount: "456.7", type: "some updated type"}
    @invalid_attrs %{amount: nil, type: nil}

    def amount_fixture(attrs \\ %{}) do
      {:ok, amount} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ledger.create_amount()

      amount
    end

    test "list_amounts/0 returns all amounts" do
      amount = amount_fixture()
      assert Ledger.list_amounts() == [amount]
    end

    test "get_amount!/1 returns the amount with given id" do
      amount = amount_fixture()
      assert Ledger.get_amount!(amount.id) == amount
    end

    test "create_amount/1 with valid data creates a amount" do
      assert {:ok, %Amount{} = amount} = Ledger.create_amount(@valid_attrs)
      assert amount.amount == Decimal.new("120.5")
      assert amount.type == "some type"
    end

    test "create_amount/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ledger.create_amount(@invalid_attrs)
    end

    test "update_amount/2 with valid data updates the amount" do
      amount = amount_fixture()
      assert {:ok, amount} = Ledger.update_amount(amount, @update_attrs)
      assert %Amount{} = amount
      assert amount.amount == Decimal.new("456.7")
      assert amount.type == "some updated type"
    end

    test "update_amount/2 with invalid data returns error changeset" do
      amount = amount_fixture()
      assert {:error, %Ecto.Changeset{}} = Ledger.update_amount(amount, @invalid_attrs)
      assert amount == Ledger.get_amount!(amount.id)
    end

    test "delete_amount/1 deletes the amount" do
      amount = amount_fixture()
      assert {:ok, %Amount{}} = Ledger.delete_amount(amount)
      assert_raise Ecto.NoResultsError, fn -> Ledger.get_amount!(amount.id) end
    end

    test "change_amount/1 returns a amount changeset" do
      amount = amount_fixture()
      assert %Ecto.Changeset{} = Ledger.change_amount(amount)
    end
  end
end
