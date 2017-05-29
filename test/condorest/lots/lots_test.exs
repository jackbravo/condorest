defmodule Condorest.EntityTest do
  use Condorest.DataCase

  alias Condorest.Entity

  describe "lots" do
    alias Condorest.Entity.Lot

    @valid_attrs %{address: "some address", code: "some code"}
    @update_attrs %{address: "some updated address", code: "some updated code"}
    @invalid_attrs %{address: nil, code: nil}

    def lot_fixture(attrs \\ %{}) do
      {:ok, lot} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entity.create_lot()

      lot
    end

    test "list_lots/0 returns all lots" do
      lot = lot_fixture()
      assert Entity.list_lots() == [lot]
    end

    test "get_lot!/1 returns the lot with given id" do
      lot = lot_fixture()
      assert Entity.get_lot!(lot.id) == lot
    end

    test "create_lot/1 with valid data creates a lot" do
      assert {:ok, %Lot{} = lot} = Entity.create_lot(@valid_attrs)
      assert lot.address == "some address"
      assert lot.code == "some code"
    end

    test "create_lot/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entity.create_lot(@invalid_attrs)
    end

    test "update_lot/2 with valid data updates the lot" do
      lot = lot_fixture()
      assert {:ok, lot} = Entity.update_lot(lot, @update_attrs)
      assert %Lot{} = lot
      assert lot.address == "some updated address"
      assert lot.code == "some updated code"
    end

    test "update_lot/2 with invalid data returns error changeset" do
      lot = lot_fixture()
      assert {:error, %Ecto.Changeset{}} = Entity.update_lot(lot, @invalid_attrs)
      assert lot == Entity.get_lot!(lot.id)
    end

    test "delete_lot/1 deletes the lot" do
      lot = lot_fixture()
      assert {:ok, %Lot{}} = Entity.delete_lot(lot)
      assert_raise Ecto.NoResultsError, fn -> Entity.get_lot!(lot.id) end
    end

    test "change_lot/1 returns a lot changeset" do
      lot = lot_fixture()
      assert %Ecto.Changeset{} = Entity.change_lot(lot)
    end
  end

  describe "contacts" do
    alias Condorest.Entity.Contact

    @valid_attrs %{is_owner: true, name: "some name", phonenumber: "some phonenumber"}
    @update_attrs %{is_owner: false, name: "some updated name", phonenumber: "some updated phonenumber"}
    @invalid_attrs %{is_owner: nil, name: nil, phonenumber: nil}

    def contact_fixture(attrs \\ %{}) do
      {:ok, contact} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entity.create_contact()

      contact
    end

    test "list_contacts/0 returns all contacts" do
      contact = contact_fixture()
      assert Entity.list_contacts() == [contact]
    end

    test "get_contact!/1 returns the contact with given id" do
      contact = contact_fixture()
      assert Entity.get_contact!(contact.id) == contact
    end

    test "create_contact/1 with valid data creates a contact" do
      assert {:ok, %Contact{} = contact} = Entity.create_contact(@valid_attrs)
      assert contact.is_owner == true
      assert contact.name == "some name"
      assert contact.phonenumber == "some phonenumber"
    end

    test "create_contact/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entity.create_contact(@invalid_attrs)
    end

    test "update_contact/2 with valid data updates the contact" do
      contact = contact_fixture()
      assert {:ok, contact} = Entity.update_contact(contact, @update_attrs)
      assert %Contact{} = contact
      assert contact.is_owner == false
      assert contact.name == "some updated name"
      assert contact.phonenumber == "some updated phonenumber"
    end

    test "update_contact/2 with invalid data returns error changeset" do
      contact = contact_fixture()
      assert {:error, %Ecto.Changeset{}} = Entity.update_contact(contact, @invalid_attrs)
      assert contact == Entity.get_contact!(contact.id)
    end

    test "delete_contact/1 deletes the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{}} = Entity.delete_contact(contact)
      assert_raise Ecto.NoResultsError, fn -> Entity.get_contact!(contact.id) end
    end

    test "change_contact/1 returns a contact changeset" do
      contact = contact_fixture()
      assert %Ecto.Changeset{} = Entity.change_contact(contact)
    end
  end
end
