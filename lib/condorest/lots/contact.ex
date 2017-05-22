defmodule Condorest.Lots.Contact do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Lots.Contact


  schema "lots_contacts" do
    field :is_owner, :boolean, default: false
    field :name, :string
    field :phonenumber, :string
    belongs_to :lot, Condorest.Lots.Lot

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
