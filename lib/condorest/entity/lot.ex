defmodule Condorest.Entity.Lot do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Entity.Lot
  alias Condorest.Entity.Contact


  schema "entity_lots" do
    field :address, :string
    field :name, :string
    belongs_to :owner, Contact
    belongs_to :lot_type, Condorest.Entity.LotType
    many_to_many :contacts, Contact, join_through: "entity_lot_contacts", unique: true, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Lot{} = lot, attrs) do
    lot
    |> cast(attrs, [:name, :address, :owner_id, :lot_type_id])
    |> validate_required([:name, :lot_type_id])
    |> unique_constraint(:name)
    |> foreign_key_constraint(:owner_id)
    |> foreign_key_constraint(:lot_type_id)
    |> put_assoc(:contacts, Condorest.Entity.list_contacts(attrs["contacts"] || []))
  end
end
