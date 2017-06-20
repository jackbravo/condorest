defmodule Condorest.Repo.Migrations.CreateCondorest.Revenue.Receipt do
  use Ecto.Migration

  def change do
    create table(:revenue_receipts) do
      add :date, :date
      add :number, :string
      add :details, :string
      add :total_amount, :decimal, precision: 20, scale: 10, null: false
      add :contact_id, references(:entity_contacts, on_delete: :nothing)
      add :entry_id, references(:ledger_entries, on_delete: :nothing)

      timestamps()
    end

    create index(:revenue_receipts, [:contact_id])


    create table(:revenue_fee_lines) do
      add :receipt_id, references(:revenue_receipts, on_delete: :delete_all)
      add :amount, :decimal, precision: 20, scale: 10, null: false
      add :date_start, :date
      add :date_end, :date
      add :lot_id, references(:entity_lots, on_delete: :nothing)

      timestamps()
    end

    create index(:revenue_fee_lines, [:receipt_id])
    create index(:revenue_fee_lines, [:lot_id])
  end
end
