defmodule GalacticDinerGuide.Restaurants.Actions.Update do
  @moduledoc """
  Updates a restaurant from database.
  """
  alias GalacticDinerGuide.{Error, Repo}
  alias GalacticDinerGuide.Restaurants.Models.Restaurant

  @doc """
  Updates a restaurant from database with the given attributes.
  """
  @spec call(binary(), map()) :: {:ok, Restaurant.t()} | {:error, Error.t()}
  def call(id, attrs) do
    case Repo.get(Restaurant, id) do
      nil -> {:error, Error.build_restaurant_not_found_error()}
      restaurant -> do_update(restaurant, attrs)
    end
  end

  defp do_update(restaurant, attrs) do
    restaurant
    |> Restaurant.changeset(attrs)
    |> Repo.update()
  end
end
