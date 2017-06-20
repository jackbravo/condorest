defmodule Condorest.Revenue.FeeLine do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Revenue.{ FeeLine, Receipt }


  schema "revenue_fee_lines" do
    belongs_to :receipt, Receipt
    field :amount, :decimal
    field :date_end, :date
    field :date_start, :date
    belongs_to :lot, Condorest.Entity.Lot

    timestamps()
  end

  @doc false
  def changeset(%FeeLine{} = fee_line, attrs) do
    fee_line
    |> cast(attrs, [:amount, :date_start, :date_end, :lot_id])
    |> validate_required([:amount, :date_start, :date_end, :lot_id])
    |> foreign_key_constraint(:lot_id)
  end
end
