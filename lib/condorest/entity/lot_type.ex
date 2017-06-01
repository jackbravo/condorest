defmodule Condorest.Entity.LotType do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Entity.LotType


  schema "entity_lot_types" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%LotType{} = lot_type, attrs) do
    lot_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
