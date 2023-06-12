defmodule GalacticDinerGuide.Restaurants.Actions.GetMostVisited do
  @moduledoc """
  Gets the most visited restaurant and the person who visited the most.
  """
  alias GalacticDinerGuide.{Error, Repo}
  alias GalacticDinerGuide.Restaurants.Queries.RestaurantQueries, as: RestaurantQuery
  alias GalacticDinerGuide.Customers.Queries.CustomerQueries, as: CustomerQuery

  @doc """
  Gets the most visited restaurant and the person who visited the most.
  """
  @spec call() :: {:ok, String.t()} | {:error, Error.t()}
  def call do
    query = RestaurantQuery.most_visited_restaurant()
    query_result = Repo.all(query)
    most_frequent_restaurant = Enum.map(query_result, fn {name, _count} -> name end)

    customer_query = CustomerQuery.get_most_frequent_customer()
    most_frequent_customer = Enum.map(customer_query, fn {id, _count} -> id end)

    case most_frequent_restaurant do
      nil ->
        {:error, Error.build_restaurant_not_found_error()}

      _ ->
        {:ok, "The most visited restaurant is: #{most_frequent_restaurant};
          The most frequent customer is: #{most_frequent_customer}"}
    end
  end
end
