defmodule Condorest.Entity.Lot do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Entity.Lot
  alias Condorest.Entity.Contact
  alias Condorest.Entity.LotContact


  schema "entity_lots" do
    field :address, :string
    field :code, :string
    many_to_many :contacts, Contact, join_through: LotContact, unique: true

    timestamps()
  end

  @doc false
  def changeset(%Lot{} = lot, attrs) do
    lot
    |> cast(attrs, [:code, :address])
    |> validate_required([:code])
    |> unique_constraint(:code)
  end

  @doc false
  def delete_changeset(%Lot{} = lot) do
    lot
    |> Ecto.Changeset.change()
    |> foreign_key_constraint(:entity_lots, name: :entity_contacts_lot_id_fkey, message: "still exist")
  end
end
