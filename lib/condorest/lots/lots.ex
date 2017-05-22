defmodule Condorest.Lots do
  @moduledoc """
  The boundary for the Lots system.
  """

  import Ecto.Query, warn: false
  alias Condorest.Repo

  alias Condorest.Lots.Lot

  @doc """
  Returns the list of lots.

  ## Examples

      iex> list_lots()
      [%Lot{}, ...]

  """
  def list_lots do
    Repo.all(Lot)
  end

  @doc """
  Returns the list of lots as a {code,id} touple so we can use it in select lists
  """
  def list_lots_for_select do
      from(l in Lot, select: {l.code, l.id}) |> Repo.all
  end

  @doc """
  Gets a single lot.

  Raises `Ecto.NoResultsError` if the Lot does not exist.

  ## Examples

      iex> get_lot!(123)
      %Lot{}

      iex> get_lot!(456)
      ** (Ecto.NoResultsError)

  """
  def get_lot!(id), do: Repo.get!(Lot, id)

  @doc """
  Creates a lot.

  ## Examples

      iex> create_lot(%{field: value})
      {:ok, %Lot{}}

      iex> create_lot(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_lot(attrs \\ %{}) do
    %Lot{}
    |> Lot.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a lot.

  ## Examples

      iex> update_lot(lot, %{field: new_value})
      {:ok, %Lot{}}

      iex> update_lot(lot, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_lot(%Lot{} = lot, attrs) do
    lot
    |> Lot.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Lot.

  ## Examples

      iex> delete_lot(lot)
      {:ok, %Lot{}}

      iex> delete_lot(lot)
      {:error, %Ecto.Changeset{}}

  """
  def delete_lot(%Lot{} = lot) do
    Repo.delete(lot)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking lot changes.

  ## Examples

      iex> change_lot(lot)
      %Ecto.Changeset{source: %Lot{}}

  """
  def change_lot(%Lot{} = lot) do
    Lot.changeset(lot, %{})
  end

  alias Condorest.Lots.Contact

  @doc """
  Returns the list of contacts.

  ## Examples

      iex> list_contacts()
      [%Contact{}, ...]

  """
  def list_contacts do
    Repo.all(Contact)
  end

  @doc """
  Gets a single contact.

  Raises `Ecto.NoResultsError` if the Contact does not exist.

  ## Examples

      iex> get_contact!(123)
      %Contact{}

      iex> get_contact!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contact!(id), do: Repo.get!(Contact, id)

  @doc """
  Creates a contact.

  ## Examples

      iex> create_contact(%{field: value})
      {:ok, %Contact{}}

      iex> create_contact(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contact(attrs \\ %{}) do
    %Contact{}
    |> Contact.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a contact.

  ## Examples

      iex> update_contact(contact, %{field: new_value})
      {:ok, %Contact{}}

      iex> update_contact(contact, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contact(%Contact{} = contact, attrs) do
    contact
    |> Contact.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Contact.

  ## Examples

      iex> delete_contact(contact)
      {:ok, %Contact{}}

      iex> delete_contact(contact)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contact(%Contact{} = contact) do
    Repo.delete(contact)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contact changes.

  ## Examples

      iex> change_contact(contact)
      %Ecto.Changeset{source: %Contact{}}

  """
  def change_contact(%Contact{} = contact) do
    Contact.changeset(contact, %{})
  end
end
