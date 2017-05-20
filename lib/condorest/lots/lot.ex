defmodule Condorest.Lots.Lot do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Lots.Lot


  schema "lots_lots" do
    field :address, :string
    field :code, :string

    timestamps()
  end

  @doc false
  def changeset(%Lot{} = lot, attrs) do
    lot
    |> cast(attrs, [:code, :address])
    |> validate_required([:code, :address])
    |> unique_constraint(:code)
  end
end
