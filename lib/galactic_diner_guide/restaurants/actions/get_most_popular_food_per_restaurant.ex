defmodule GalacticDinerGuide.Restaurants.Actions.GetMostPopularFoodPerRestaurant do
  @moduledoc """
  Retrieves the most popular food in a specific restaurant.
  """
  alias GalacticDinerGuide.{Error, Repo}
  alias GalacticDinerGuide.Restaurants.Queries.RestaurantQueries, as: Query

  @doc """
  Retrieves the most popular food in a specific restaurant.
  """
  @spec call(String.t()) :: {:ok, integer()} | {:error, Error.t()}
  def call(restaurant_name) do
    query = Query.get_most_popular_food_by_restaurant(restaurant_name)
    [result | _] = Repo.all(query)
    result

    case result do
      popular_food ->
        popular_food_as_string =
          popular_food
          |> Tuple.to_list()
          |> List.to_string()

        {:ok, popular_food_as_string}

      nil ->
        {:error, Error.build_restaurant_not_found_error()}
    end
  end
end
