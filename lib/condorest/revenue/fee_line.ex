defmodule Condorest.Revenue.FeeLine do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Revenue.{ FeeLine, Receipt }


  schema "revenue_fee_lines" do
    belongs_to :receipt, Receipt
    field :amount, :decimal, default: Decimal.new(0.0)
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
    |> validate_dates()
    |> foreign_key_constraint(:lot_id)
  end

  def validate_dates(changeset) do
    date_start = Ecto.Changeset.get_field(changeset, :date_start)
    date_end = Ecto.Changeset.get_field(changeset, :date_end)

    if (date_start && date_end && Date.compare(date_start, date_end) == :gt) do
      add_error(changeset, :date_end, "Date end must be later than date start")
    else
      changeset
    end
  end
end
