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

    case Get.call(id) do
      # coveralls-ignore-start
      nil ->
        # coveralls-ignore-stop
        {:error, Error.build_restaurant_not_found_error()}

      _ ->
        Update.call(id, attrs)
    end
  end
end
