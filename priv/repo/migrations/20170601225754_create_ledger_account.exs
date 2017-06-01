defmodule Condorest.Repo.Migrations.CreateCondorest.Ledger.Account do
  use Ecto.Migration

  def change do
    create table(:ledger_accounts) do
      add :name, :string
      add :type, :string
      add :contra, :boolean, default: false, null: false

      timestamps()
    end

  end
end
