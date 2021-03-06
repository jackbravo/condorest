defmodule Condorest.Entity.Contact do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Entity.Contact
  alias Condorest.Entity.Lot


  schema "entity_contacts" do
    field :name, :string
    field :phonenumber, :string
    field :details, :string
    has_many :lots_owned, Lot, foreign_key: :owner_id, on_replace: :nilify
    many_to_many :lots, Lot, join_through: "entity_lot_contacts", unique: true, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Contact{} = contact, attrs) do
    contact
    |> cast(attrs, [:name, :phonenumber, :details])
    |> validate_required([:name])
    |> put_assoc(:lots, Condorest.Entity.list_lots(attrs["lots"] || []))
    |> put_assoc(:lots_owned, Condorest.Entity.list_lots(attrs["lots_owned"] || []))
  end
end
