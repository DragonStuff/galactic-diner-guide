defmodule GalacticDinerGuide.Restaurants.Actions.GetMostLucrativeFoodPerRestaurant do
  @moduledoc """
  Retrieves the most lucrative food in a specific restaurant.
  """
  alias GalacticDinerGuide.{Error, Repo}
  alias GalacticDinerGuide.Restaurants.Queries.RestaurantQueries, as: Query

  @doc """
  Retrieves the most lucrative food in a specific restaurant.
  """
  @spec call(String.t()) :: {:ok, integer()} | {:error, Error.t()}
  def call(restaurant_name) do
    query = Query.most_profitable_dish_per_restaurant(restaurant_name)
    [result | _] = Repo.all(query)
    result

    case result do
      lucrative_food ->
        lucrative_food_as_string =
          lucrative_food
          |> Tuple.to_list()
          |> List.to_string()

        {:ok, lucrative_food_as_string}

      nil ->
        {:error, Error.build_restaurant_not_found_error()}
    end
  end
end
