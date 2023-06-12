defmodule GalacticDinerGuide.Items.Queries.ItemQueries do
  @moduledoc """
  Queries for the items table.
  """
  import Ecto.Query

  alias GalacticDinerGuide.Items.Models.Item

  @doc """
  Query for items tables
  """
  @spec query :: Ecto.Query.t()
  def query do
    from(i in Item)
  end

  @doc """
  Count how many items there are in database.
  """
  @spec count_total_items :: integer()
  def count_total_items do
    query()
    |> select([i], count(i.id))
  end
end
