defmodule Condorest.Repo.Migrations.CreateCondorest.Revenue.Receipt do
  use Ecto.Migration

  def change do
    create table(:revenue_receipts) do
      add :date, :date
      add :number, :string
      add :details, :string
      add :total_amount, :decimal
      add :asset_id, references(:ledger_accounts, on_delete: :nothing)
      add :revenue_id, references(:ledger_accounts, on_delete: :nothing)
      add :contact_id, references(:entity_contacts, on_delete: :nothing)

      timestamps()
    end

    create index(:revenue_receipts, [:asset_id])
    create index(:revenue_receipts, [:revenue_id])
    create index(:revenue_receipts, [:contact_id])
  end
end
