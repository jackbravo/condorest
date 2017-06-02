defmodule Condorest.Ledger.Amount do
  @moduledoc """
  An Amount represents the individual debit or credit for a given account and is
  part of a balanced entry.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Ledger.{ Amount, Entry, Account }


  schema "ledger_amounts" do
    field :amount, :decimal
    field :type, :string

    belongs_to :entry, Entry
    belongs_to :account, Account
  end

  @amount_types ["credit", "debit"]

  @doc false
  def changeset(%Amount{} = amount, attrs) do
    amount
    |> cast(attrs, [:type, :amount])
    |> validate_required([:type, :amount])
    |> validate_number(:amount, greater_than_or_equal_to: 0)
    |> validate_inclusion(:type, @amount_types)
  end
end
