defmodule GalacticDinerGuide.Customers.Actions.GetMostFrequentVisitor do
  @moduledoc """
  Get the customer who most visited restaurants, and the customer who visited each restaurant the most.
  """
  alias GalacticDinerGuide.{Error, Repo}
  alias GalacticDinerGuide.Customers.Queries.CustomerQueries, as: Query

  @restaurant_a "the-restaurant-at-the-end-of-the-universe"
  @restaurant_b "bean-juice-stand"
  @restaurant_c "johnnys-cashew-stand"
  @restaurant_d "the-ice-cream-parlor"

  @doc """
  Get the customer who most visited restaurants, and the customer who visited each restaurant the most.
  """
  @spec call() :: {:ok, String.t()} | {:error, Error.t()}
  def call do
    most_frequent_customer_overall =
      Query.get_most_frequent_customer_overall()
      |> Repo.one()

    top_visitor = elem(most_frequent_customer_overall, 0)
    total_visits = elem(most_frequent_customer_overall, 1)

    case most_frequent_customer_overall do
      nil ->
        {:error, Error.build_restaurant_not_found_error()}

      _ ->
        result =
          {:ok,
           "The most frequent customer overall is: #{top_visitor}, with #{total_visits} visits; 
        the persons who most visited each restaurant are: 
        #{Map.get(most_frequent_customer_per_restaurant(@restaurant_a), :first_name)}, #{@restaurant_a}, #{Map.get(most_frequent_customer_per_restaurant(@restaurant_a), :count)} visits;
        #{Map.get(most_frequent_customer_per_restaurant(@restaurant_b), :first_name)}, #{@restaurant_b}, #{Map.get(most_frequent_customer_per_restaurant(@restaurant_b), :count)} visits;
        #{Map.get(most_frequent_customer_per_restaurant(@restaurant_c), :first_name)}, #{@restaurant_c}, #{Map.get(most_frequent_customer_per_restaurant(@restaurant_c), :count)} visits;
        #{Map.get(most_frequent_customer_per_restaurant(@restaurant_d), :first_name)}, #{@restaurant_d}, #{Map.get(most_frequent_customer_per_restaurant(@restaurant_d), :count)} visits"}

        response =
          result
          |> elem(1)
          |> String.replace("\n", "")

        {:ok, response}
    end
  end

  defp most_frequent_customer_per_restaurant(restaurant_name) do
      Query.most_frequent_customer_per_restaurant(restaurant_name)
      |> Repo.one()
  end
end
