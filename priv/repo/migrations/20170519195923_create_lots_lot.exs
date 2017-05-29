defmodule Condorest.Repo.Migrations.CreateCondorest.Entity.Lot do
  use Ecto.Migration

  def change do
    create table(:entity_lots) do
      add :code, :string
      add :address, :string

      timestamps()
    end

    create unique_index(:entity_lots, [:code])
  end
end
