defmodule Condorest.Repo.Migrations.CreateCondorest.Ledger.Account do
  use Ecto.Migration

  def change do
    create table(:ledger_accounts) do
      add :name, :string
      add :type, :string
      add :contra, :boolean, default: false, null: false

      timestamps()
    end
    create unique_index(:ledger_accounts, [:name])
    create index(:ledger_accounts, [:type, :name])


    create table(:ledger_entries) do
      add :description, :string
      add :date, :date

      timestamps()
    end
    create index(:ledger_entries, [:date])


    create table(:ledger_amounts) do
      add :type, :string
      add :amount, :decimal, precision: 20, scale: 10, null: false
      add :account_id, references(:ledger_accounts, on_delete: :delete_all)
      add :entry_id, references(:ledger_entries, on_delete: :delete_all)
    end
    create index(:ledger_amounts, [:type])
    create index(:ledger_amounts, [:account_id])
    create index(:ledger_amounts, [:entry_id])

  end
end
