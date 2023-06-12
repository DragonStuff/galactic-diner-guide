defmodule GalacticDinerGuide.Restaurants.Actions.Undelete do
  @moduledoc """
  Soft undeletes a restaurant from database.
  """
  alias GalacticDinerGuide.Error
  alias GalacticDinerGuide.Restaurants.Actions.{Get, Update}
  alias GalacticDinerGuide.Restaurants.Models.Restaurant

  @doc """
  Soft undeletes a restaurant with the given id.
  """
  @spec call(binary()) :: {:ok, Restaurant.t()} | {:error, Error.t()}
  def call(id) do
    attrs = %{
      deleted_at: nil,
      is_enabled: true
    }

    case GetRestaurant.call(id) do
      nil ->
        {:error, Error.build_restaurant_not_found_error()}

      _ ->
        UpdateRestaurant.call(id, %{
          is_enabled: false,
          deleted_at: DateTime.utc_now()
        })
    end
  end
end
