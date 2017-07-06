defmodule Condorest.Revenue do
  @moduledoc """
  The boundary for the Revenue system.
  """

  import Ecto.Query, warn: false
  alias Condorest.Repo

  alias Condorest.Revenue.Receipt
  alias Condorest.Ledger.Entry

  @doc """
  Returns the list of receipts.

  ## Examples

      iex> list_receipts()
      [%Receipt{}, ...]

  """
  def list_receipts do
    Repo.all(Receipt)
  end

  @doc """
  Gets a single receipt.

  Raises `Ecto.NoResultsError` if the Receipt does not exist.

  ## Examples

      iex> get_receipt!(123)
      %Receipt{}

      iex> get_receipt!(456)
      ** (Ecto.NoResultsError)

  """
  def get_receipt!(id) do
    Repo.get!(Receipt, id)
    |> Repo.preload(:contact)
    |> Repo.preload(fee_lines: :lot)
    |> Repo.preload(entry: :amounts)
  end

  def insert_or_update_receipt_with_entry(receipt, attrs) do
    Ecto.Multi.new
    |> Ecto.Multi.run(:entry, &insert_or_update_entry_from_receipt(&1, receipt, attrs))
    |> Ecto.Multi.run(:receipt, &insert_or_update_receipt(&1, receipt, attrs))
    |> Repo.transaction()
  end

  defp insert_or_update_entry_from_receipt(_changes, %Receipt{} = receipt, attrs) do
    revenue_id = Condorest.Ledger.account_id_from_name("Fees")
    entry = get_entry_from_receipt(receipt)
    [a1, a2 | _] =
      case length(entry.amounts) do
        2 -> entry.amounts
        _ -> [%{id: nil}, %{id: nil}]
      end
    entry_attr = %{ date: attrs["date"], amounts: [
      %{ type: "debit", amount: attrs["total_amount"], account_id: attrs["asset_id"], id: a1.id },
      %{ type: "credit", amount: attrs["total_amount"], account_id: revenue_id, id: a2.id }
    ]}
    Repo.insert_or_update Entry.changeset(entry, entry_attr)
  end

  defp get_entry_from_receipt(%Receipt{entry_id: nil}),
    do: %Entry{amounts: []}
  defp get_entry_from_receipt(%Receipt{} = receipt),
    do: receipt.entry

  defp insert_or_update_receipt(%{entry: entry}, receipt, attrs) do
    Repo.insert_or_update Receipt.changeset(receipt, entry, attrs)
  end

  @doc """
  Deletes a Receipt.

  ## Examples

      iex> delete_receipt(receipt)
      {:ok, %Receipt{}}

      iex> delete_receipt(receipt)
      {:error, %Ecto.Changeset{}}

  """
  def delete_receipt(%Receipt{} = receipt) do
    Repo.delete(receipt)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking receipt changes.

  ## Examples

      iex> change_receipt(receipt)
      %Ecto.Changeset{source: %Receipt{}}

  """
  def change_receipt(%Receipt{} = receipt) do
    Receipt.changeset(receipt, %{})
  end
end
