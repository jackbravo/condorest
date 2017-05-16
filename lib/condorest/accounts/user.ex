defmodule Condorest.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Accounts.User


  schema "accounts_users" do
    field :name, :string
    field :password_hash, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :username, :password_hash])
    |> validate_required([:name, :username, :password_hash])
    |> unique_constraint(:username)
  end
end
