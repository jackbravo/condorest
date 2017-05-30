defmodule Condorest.Entity.Contact do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Entity.Contact
  alias Condorest.Entity.Lot


  schema "entity_contacts" do
    field :name, :string
    field :phonenumber, :string
    field :details, :string
    many_to_many :lots, Lot, join_through: "entity_lot_contacts", unique: true

    timestamps()
  end

  @doc false
  def changeset(%Contact{} = contact, attrs) do
    contact
    |> cast(attrs, [:name, :phonenumber, :details])
    |> validate_required([:name])
  end
end
