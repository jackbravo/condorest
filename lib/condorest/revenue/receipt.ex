defmodule Condorest.Revenue.Receipt do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Revenue.Receipt


  schema "revenue_receipts" do
    field :date, :date
    field :details, :string
    field :number, :string
    field :total_amount, :decimal
    field :asset_id, :id
    field :revenue_id, :id
    field :contact_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Receipt{} = receipt, attrs) do
    receipt
    |> cast(attrs, [:date, :number, :details, :total_amount])
    |> validate_required([:date, :number, :details, :total_amount])
  end
end
