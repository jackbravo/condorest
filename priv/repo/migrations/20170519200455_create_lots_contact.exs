defmodule Condorest.Repo.Migrations.CreateCondorest.Entity.Contact do
  use Ecto.Migration

  def change do
    create table(:entity_contacts) do
      add :name, :string
      add :phonenumber, :string
      add :details, :string

      timestamps()
    end

    create table(:entity_lot_contacts, primary_key: false) do
      add :lot_id, references(:entity_lots, on_delete: :delete_all)
      add :contact_id, references(:entity_contacts, on_delete: :delete_all)
      add :is_owner, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:entity_lot_contacts, [:lot_id, :contact_id])
  end
end
