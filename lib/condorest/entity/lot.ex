defmodule Condorest.Entity.Lot do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Entity.Lot
  alias Condorest.Entity.Contact


  schema "entity_lots" do
    field :address, :string
    field :code, :string
    belongs_to :owner, Contact
    many_to_many :contacts, Contact, join_through: "entity_lot_contacts", unique: true, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Lot{} = lot, attrs) do
    lot
    |> cast(attrs, [:code, :address, :owner_id])
    |> validate_required([:code])
    |> unique_constraint(:code)
    |> foreign_key_constraint(:owner_id)
    |> put_assoc(:contacts, Condorest.Entity.list_contacts(attrs["contacts"] || []))
  end
end
