defmodule GalacticDinerGuide.RestaurantCustomers.Actions.Delete do
  @moduledoc """
  Soft deletes a restaurant_customer from database.
  """
  alias GalacticDinerGuide.Error
  alias GalacticDinerGuide.RestaurantCustomers.Actions.{Get, Update}
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer

  @doc """
  Soft deletes a restaurant_customer with the given id.
  """
  @spec call(binary()) :: {:ok, RestaurantCustomer.t()} | {:error, Error.t()}
  def call(id) do
    attrs = %{
      deleted_at: DateTime.utc_now(),
      is_enabled: false
    }

    case Get.call(id) do
      # coveralls-ignore-start
      nil ->
        # coveralls-ignore-stop
        {:error, Error.build_order_not_found_error()}

      _ ->
        Update.call(id, attrs)
    end
  end
end
