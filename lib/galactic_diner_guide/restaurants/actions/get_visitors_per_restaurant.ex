defmodule GalacticDinerGuide.Restaurants.Actions.GetVisitorsPerRestaurant do
  @moduledoc """
  Calculates how many visitants a specific restaurant has received.
  """
  alias GalacticDinerGuide.{Error, Repo}
  alias GalacticDinerGuide.Restaurants.Queries.RestaurantQueries, as: Query

  @doc """
  Calculates how many visitants a specific restaurant has received.
  """
  @spec call(String.t()) :: {:ok, integer()} | {:error, Error.t()}
  def call(restaurant_name) do
    visitors =
      restaurant_name
      |> Query.count_visitors_per_restaurant()
      |> Repo.one()

    case visitors do
      nil -> {:error, Error.build_restaurant_not_found_error()}
      total -> {:ok, total}
    end
  end
end
