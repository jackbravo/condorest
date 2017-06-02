defmodule Condorest.Repo.Migrations.CreateCondorest.Entity.Contact do
  use Ecto.Migration

  def change do
    create table(:entity_lot_types) do
      add :name, :string
      timestamps()
    end
    create unique_index(:entity_lot_types, [:name])

    create table(:entity_contacts) do
      add :name, :string
      add :phonenumber, :string
      add :details, :string

      timestamps()
    end

    create table(:entity_lots) do
      add :name, :string
      add :address, :string
      add :owner_id, references(:entity_contacts, on_delete: :nilify_all)
      add :lot_type_id, references(:entity_lot_types, on_delete: :nilify_all)

      timestamps()
    end

    create unique_index(:entity_lots, [:name])

    create table(:entity_lot_contacts, primary_key: false) do
      add :lot_id, references(:entity_lots, on_delete: :delete_all)
      add :contact_id, references(:entity_contacts, on_delete: :delete_all)
    end

    create unique_index(:entity_lot_contacts, [:lot_id, :contact_id])
  end
end
