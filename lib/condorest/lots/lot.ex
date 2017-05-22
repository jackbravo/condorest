defmodule Condorest.Lots.Lot do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Lots.Lot


  schema "lots_lots" do
    field :address, :string
    field :code, :string
    has_many :contacts, Condorest.Lots.Contact

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
    |> foreign_key_constraint(:lots_lots, name: :lots_contacts_lot_id_fkey, message: "still exist")
  end
end
