defmodule Condorest.Ledger.Account do
  @moduledoc """
  This module uses code and ideas from:

  - https://github.com/mbulat/plutus
  - https://github.com/davidkuhta/fuentes

  The Account module represents accounts in the system which. Each account must
  be set to one of the following types:

      | TYPE      | NORMAL BALANCE | DESCRIPTION                                              |
      | :-------- | :-------------:| :--------------------------------------------------------|
      | asset     | Debit          | Resources owned by the Business Entity                   |
      | liability | Credit         | Debts owed to outsiders                                  |
      | equity    | Credit         | Owners rights to the Assets                              |
      | revenue   | Credit         | Increases in owners equity                               |
      | expense   | Debit          | Assets or services consumed in the generation of revenue |

  Each account can also be marked as a _Contra Account_. A contra account will have it's
  normal balance swapped. For example, to remove equity, a "Drawing" account may be created
  as a contra equity account as follows:

      `account = %Account{name: "Drawing", type: "asset", contra: true}`

  At all times the balance of all accounts should conform to the "accounting equation"

      *Assets = Liabilities + Owner's Equity*

  Each account type acts as it's own ledger.

  For more details see:

  [Wikipedia - Accounting Equation](http://en.wikipedia.org/wiki/Accounting_equation)
  [Wikipedia - Debits, Credits, and Contra Accounts](http://en.wikipedia.org/wiki/Debits_and_credits)
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Condorest.Ledger.Account


  schema "ledger_accounts" do
    field :name, :string
    field :type, :string
    field :contra, :boolean, default: false
    field :balance, :decimal, virtual: true

    timestamps()
  end

  def debit_types, do: ["asset", "expense"]
  def credit_types, do: ["liability", "equity", "revenue"]
  def types, do: credit_types() ++ debit_types()

  @doc false
  def changeset(%Account{} = account, attrs) do
    account
    |> cast(attrs, [:name, :type, :contra])
    |> validate_required([:name, :type])
    |> validate_inclusion(:type, types())
  end
end
