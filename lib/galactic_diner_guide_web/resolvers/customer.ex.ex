defmodule GalacticDinerGuideWeb.Graphql.Resolvers.Customer do
@moduledoc """
Resolvers for :customers table.
"""
  alias GalacticDinerGuide.Customers.Actions.GetMostFrequentVisitor

  def get_most_frequent_visitor(%{key: key}, _conn) do
    {:ok, frequent_visitors} = GetMostFrequentVisitor.call()

    case is_bitstring(frequent_visitors) do
      true ->
        {:ok, %{key: key, most_frequent_visitors: frequent_visitors}}

      false ->
        {:ok, %{key: key, most_frequent_visitors: "No frequent visitors found"}}
    end
  end
end
