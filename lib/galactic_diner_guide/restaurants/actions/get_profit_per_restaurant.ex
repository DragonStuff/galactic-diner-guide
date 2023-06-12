defmodule GalacticDinerGuide.Restaurants.Actions.GetProfitPerRestaurant do
  @moduledoc """
  Calculates the total profit of a specific restaurant.
  """
  alias GalacticDinerGuide.{Error, Repo}
  alias GalacticDinerGuide.Restaurants.Queries.RestaurantQueries, as: Query

  @doc """
  Calculates how much profit a specific restaurant has made.
  """
  @spec call(String.t()) :: {:ok, integer()} | {:error, Error.t()}
  def call(restaurant_name) do
    result =
      restaurant_name
      |> Query.get_total_food_costs_by_restaurant_name()
      |> Repo.one()

    case result do
      total -> {:ok, total}
      nil -> {:error, Error.build_restaurant_not_found_error()}
    end
  end
end
