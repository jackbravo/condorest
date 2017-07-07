defmodule Condorest.Form.Date do
  @behaviour Ecto.Type
  def type, do: :date

  def cast(string) when is_binary(string) do
    case Date.from_iso8601(string) do
      {:ok, _} = ok -> ok
      {:error, _} -> :error
    end
  end

  def cast(_), do: :error

  def load(term) do
    load_date(term)
  end

  defp load_date({year, month, day}),
    do: {:ok, %Date{year: year, month: month, day: day}}
  defp load_date(_),
    do: :error

  def dump(%Date{year: year, month: month, day: day}),
    do: {:ok, {year, month, day}}
  def dump(_), do: :error
end

