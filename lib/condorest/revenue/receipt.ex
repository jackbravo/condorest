defmodule Condorest.Revenue.Receipt do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Revenue.Receipt


  schema "revenue_receipts" do
    field :date, Condorest.Form.Date
    field :details, :string
    field :number, :string
    field :total_amount, :decimal, default: Decimal.new(0)
    belongs_to :contact, Condorest.Entity.Contact    
    belongs_to :entry, Condorest.Ledger.Entry
    has_many :fee_lines, Condorest.Revenue.FeeLine

    timestamps()
  end

  @doc false
  def changeset(%Receipt{} = receipt, attrs) do
    receipt
    |> cast(attrs, [:date, :number, :details, :total_amount, :contact_id])
    |> validate_required([:date, :number, :total_amount, :contact_id])
    |> cast_assoc(:fee_lines)
    |> validate_amounts()
    |> foreign_key_constraint(:contact_id)
  end

  def changeset(%Receipt{} = receipt, %Condorest.Ledger.Entry{} = entry, attrs) do
    receipt
    |> changeset(attrs)
    |> put_assoc(:entry, entry)
  end

  def validate_amounts(changeset) do
    fee_lines = Ecto.Changeset.get_field(changeset, :fee_lines)

    total_amount = Enum.reduce(fee_lines, Decimal.new(0.0), &(Decimal.add(&1.amount, &2)))

    if Decimal.equal?(total_amount, get_field(changeset, :total_amount)) do
      changeset
    else
      add_error(changeset, :total_amount, "Fee lines amounts doesn't add up to total_amount")
    end
  end
end
