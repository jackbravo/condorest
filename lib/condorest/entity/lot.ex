defmodule Condorest.Entity.Lot do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Entity.Lot
  alias Condorest.Entity.Contact


  schema "entity_lots" do
    field :address, :string
    field :code, :string
    belongs_to :contact, Contact
    many_to_many :contacts, Contact, join_through: "entity_lot_contacts", unique: true

    timestamps()
  end

  @doc false
  def changeset(%Lot{} = lot, attrs) do
    lot
    |> cast(attrs, [:code, :address, :contact_id])
    |> validate_required([:code])
    |> unique_constraint(:code)
    |> foreign_key_constraint(:contact_id)
  end
end
