defmodule Condorest.Repo.Migrations.CreateCondorest.Lots.Contact do
  use Ecto.Migration

  def change do
    create table(:lots_contacts) do
      add :name, :string
      add :phonenumber, :string
      add :is_owner, :boolean, default: false, null: false
      add :lot_id, references(:lots_lots)

      timestamps()
    end

    create index(:lots_contacts, [:lot_id])
  end
end
