defmodule GalacticDinerGuide.Restaurants.Actions.Get do
  @moduledoc """
  Gets a restaurant from database.
  """
  alias GalacticDinerGuide.{Error, Repo}
  alias GalacticDinerGuide.Restaurants.Models.Restaurant

  @doc """
  Gets a restaurant from database with the given id.
  """
  @spec call(binary()) :: {:ok, Restaurant.t()} | {:error, Error.t()}
  def call(id) do
    case Repo.get(Restaurant, id) do
      nil -> {:error, Error.build_restaurant_not_found_error()}
      restaurant -> {:ok, restaurant}
    end
  end
end
