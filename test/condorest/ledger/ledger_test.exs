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
end
