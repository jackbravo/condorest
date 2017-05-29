defmodule Condorest.Entity.Contact do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Entity.Contact


  schema "entity_contacts" do
    field :is_owner, :boolean, default: false
    field :name, :string
    field :phonenumber, :string
    belongs_to :lot, Condorest.Entity.Lot

    timestamps()
  end

  @doc false
  def changeset(%Contact{} = contact, attrs) do
    contact
    |> cast(attrs, [:name, :phonenumber, :is_owner, :lot_id])
    |> validate_required([:name])
    |> assoc_constraint(:lot)
  end
end
