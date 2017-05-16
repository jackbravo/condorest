defmodule Condorest.Repo.Migrations.CreateCondorest.Accounts.User do
  use Ecto.Migration

  def change do
    create table(:accounts_users) do
      add :name, :string
      add :username, :string
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:accounts_users, [:username])
  end
end
