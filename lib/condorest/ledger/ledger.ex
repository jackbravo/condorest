defmodule Condorest.Ledger do
  @moduledoc """
  The boundary for the Ledger system.
  """

  import Ecto.Query, warn: false
  alias Condorest.Repo

  alias Condorest.Ledger.Account

  @doc """
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  def list_accounts do
    Repo.all(Account)
  end

  def account_id_from_name(name) do
    Repo.one!(from a in Account, where: a.name == ^name, select: a.id)
  end

  def accounts_for_select do
    Account |> names_and_ids |> Repo.all
  end

  def asset_accounts_for_select do
    Account
    |> names_and_ids
    |> for_asset_accounts
    |> Repo.all
  end

  def names_and_ids(query) do
    from i in query, select: { i.name, i.id }
  end

  def for_debit_accounts(query) do
    from a in query, where: a.type in ^Account.debit_types()
  end

  def for_credit_accounts(query) do
    from a in query, where: a.type in ^Account.credit_types()
  end

  def for_asset_accounts(query) do
    from a in query, where: a.type == ^"asset"
  end

  @doc """
  Gets a single account.

  Raises `Ecto.NoResultsError` if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

      iex> get_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account!(id), do: Repo.get!(Account, id)

  @doc """
  Creates a account.

  ## Examples

      iex> create_account(%{field: value})
      {:ok, %Account{}}

      iex> create_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a account.

  ## Examples

      iex> update_account(account, %{field: new_value})
      {:ok, %Account{}}

      iex> update_account(account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Account.

  ## Examples

      iex> delete_account(account)
      {:ok, %Account{}}

      iex> delete_account(account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account(%Account{} = account) do
    Repo.delete(account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account(account)
      %Ecto.Changeset{source: %Account{}}

  """
  def change_account(%Account{} = account) do
    Account.changeset(account, %{})
  end

  alias Condorest.Ledger.Entry

  @doc """
  Returns the list of entries.

  ## Examples

      iex> list_entries()
      [%Entry{}, ...]

  """
  def list_entries do
    Repo.all(Entry)
  end

  @doc """
  Gets a single entry.

  Raises `Ecto.NoResultsError` if the Entry does not exist.

  ## Examples

      iex> get_entry!(123)
      %Entry{}

      iex> get_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_entry!(id), do: Repo.get!(Entry, id) |> Repo.preload(amounts: :account)

  @doc """
  Creates a entry.

  ## Examples

      iex> create_entry(%{field: value})
      {:ok, %Entry{}}

      iex> create_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_entry(attrs \\ %{}) do
    %Entry{}
    |> Entry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a entry.

  ## Examples

      iex> update_entry(entry, %{field: new_value})
      {:ok, %Entry{}}

      iex> update_entry(entry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_entry(%Entry{} = entry, attrs) do
    entry
    |> Entry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Entry.

  ## Examples

      iex> delete_entry(entry)
      {:ok, %Entry{}}

      iex> delete_entry(entry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_entry(%Entry{} = entry) do
    Repo.delete(entry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking entry changes.

  ## Examples

      iex> change_entry(entry)
      %Ecto.Changeset{source: %Entry{}}

  """
  def change_entry(%Entry{} = entry) do
    Entry.changeset(entry, %{})
  end

  alias Condorest.Ledger.Amount

  @doc """
  Returns the list of amounts.

  ## Examples

      iex> list_amounts()
      [%Amount{}, ...]

  """
  def list_amounts do
    Repo.all(Amount)
  end

  @doc """
  Gets a single amount.

  Raises `Ecto.NoResultsError` if the Amount does not exist.

  ## Examples

      iex> get_amount!(123)
      %Amount{}

      iex> get_amount!(456)
      ** (Ecto.NoResultsError)

  """
  def get_amount!(id), do: Repo.get!(Amount, id)

  @doc """
  Creates a amount.

  ## Examples

      iex> create_amount(%{field: value})
      {:ok, %Amount{}}

      iex> create_amount(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_amount(attrs \\ %{}) do
    %Amount{}
    |> Amount.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a amount.

  ## Examples

      iex> update_amount(amount, %{field: new_value})
      {:ok, %Amount{}}

      iex> update_amount(amount, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_amount(%Amount{} = amount, attrs) do
    amount
    |> Amount.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Amount.

  ## Examples

      iex> delete_amount(amount)
      {:ok, %Amount{}}

      iex> delete_amount(amount)
      {:error, %Ecto.Changeset{}}

  """
  def delete_amount(%Amount{} = amount) do
    Repo.delete(amount)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking amount changes.

  ## Examples

      iex> change_amount(amount)
      %Ecto.Changeset{source: %Amount{}}

  """
  def change_amount(%Amount{} = amount) do
    Amount.changeset(amount, %{})
  end
end
