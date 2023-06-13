defmodule GalacticDinerGuide.Restaurants.Actions.GetMostProfitableFoodPerRestaurant do
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
    result = Repo.one(query)
  
    case result do
      profitable_food ->

        {:ok, profitable_food}

      nil ->
        {:error, Error.build_restaurant_not_found_error()}
    end
  end
end
