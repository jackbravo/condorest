defmodule Condorest.Repo.Migrations.CreateCondorest.Entity.Contact do
  use Ecto.Migration

  def change do
    create table(:entity_contacts) do
      add :name, :string
      add :phonenumber, :string
      add :is_owner, :boolean, default: false, null: false
      add :lot_id, references(:entity_lots)

      timestamps()
    end

    create index(:entity_contacts, [:lot_id])
  end
end
