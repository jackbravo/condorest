defmodule Condorest.Entity.LotContact do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Entity.LotContact
  alias Condorest.Entity.Lot
  alias Condorest.Entity.Contact


  @primary_key false
  schema "entity_lot_contacts" do
    field :is_owner, :boolean, default: false
    belongs_to :lot, Lot
    belongs_to :contact, Contact

    timestamps()
  end

  @doc false
  def changeset(%LotContact{} = contact, attrs) do
    contact
    |> cast(attrs, [:lot_id, :contact_id, :is_owner])
    |> validate_required([:lot_id, :contact_id])
  end
end
