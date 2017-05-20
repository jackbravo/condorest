defmodule Condorest.Repo.Migrations.CreateCondorest.Lots.Lot do
  use Ecto.Migration

  def change do
    create table(:lots_lots) do
      add :code, :string
      add :address, :string

      timestamps()
    end

    create unique_index(:lots_lots, [:code])
  end
end
