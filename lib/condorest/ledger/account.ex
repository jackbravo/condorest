defmodule Condorest.Ledger.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Ledger.Account


  schema "ledger_accounts" do
    field :name, :string
    field :type, :string
    field :contra, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%Account{} = account, attrs) do
    account
    |> cast(attrs, [:name, :type, :contra])
    |> validate_required([:name, :type, :contra])
  end
end
