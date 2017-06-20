defmodule Condorest.Revenue.Receipt do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Revenue.Receipt


  schema "revenue_receipts" do
    field :date, :date
    field :details, :string
    field :number, :string
    field :total_amount, :decimal
    belongs_to :contact, Condorest.Entity.Contact    
    belongs_to :entry, Condorest.Ledger.Entry
    has_many :fee_lines, Condorest.Revenue.FeeLine

    timestamps()
  end

  @doc false
  def changeset(%Receipt{} = receipt, attrs) do
    receipt
    |> cast(attrs, [:date, :number, :details, :total_amount, :contact_id])
    |> validate_required([:date, :number, :details, :total_amount, :contact_id])
    |> foreign_key_constraint(:contact_id)
  end
end
