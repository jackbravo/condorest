defmodule Condorest.Ledger.Entry do
  @moduledoc """
  Entries are the recording of account debits and credits and can be considered
  as consituting a traditional accounting Journal.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Ledger.{ Entry, Amount }


  schema "ledger_entries" do
    field :date, :date
    field :description, :string

    has_many :amounts, Amount

    timestamps()
  end

  @doc false
  def changeset(%Entry{} = entry, attrs) do
    entry
    |> cast(attrs, [:description, :date])
    |> validate_required([:description, :date])
    |> cast_assoc(:amounts)
    |> validate_debits_and_credits_balance
  end

  @doc """
  Accepts and returns a changeset, appending an error if "credit" and "debit" amounts
  are not equivalent
  """
  def validate_debits_and_credits_balance(changeset) do
    amounts = Ecto.Changeset.get_field(changeset, :amounts)
    amounts = Enum.group_by(amounts, fn(i) -> i.type end)

    credit_sum = Enum.reduce(amounts["credit"], Decimal.new(0.0), fn(i, acc) -> Decimal.add(i.amount,acc) end )
    debit_sum = Enum.reduce(amounts["debit"], Decimal.new(0.0), fn(i, acc) -> Decimal.add(i.amount,acc) end )

    if credit_sum == debit_sum do
      changeset
    else
      add_error(changeset, :amounts, "Credit and Debit amounts must be equal")
    end
  end
end
