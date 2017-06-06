# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Condorest.Repo.insert!(%Condorest.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Condorest.Repo

alias Condorest.Entity.LotType

Repo.insert! %LotType{ name: "House" }
Repo.insert! %LotType{ name: "Lot" }

alias Condorest.Ledger.Account

Repo.insert! %Account{ name: "Cash", type: "asset" }
Repo.insert! %Account{ name: "Bank", type: "asset" }
Repo.insert! %Account{ name: "Fees", type: "revenue" }
Repo.insert! %Account{ name: "Deposits", type: "revenue" }
Repo.insert! %Account{ name: "Administrative", type: "expense" }
Repo.insert! %Account{ name: "Purchases", type: "expense" }
