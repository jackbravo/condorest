defmodule Condorest.Lots.Contact do
  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Lots.Contact


  schema "lots_contacts" do
    field :is_owner, :boolean, default: false
    field :name, :string
    field :phonenumber, :string
    field :lot_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Contact{} = contact, attrs) do
    contact
    |> cast(attrs, [:name, :phonenumber, :is_owner])
    |> validate_required([:name, :phonenumber, :is_owner])
  end
end
