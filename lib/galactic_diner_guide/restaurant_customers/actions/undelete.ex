defmodule GalacticDinerGuide.RestaurantCustomers.Actions.Undelete do
  @moduledoc """
  Soft undeletes an restaurant_customer from database.
  """
  alias GalacticDinerGuide.Error
  alias GalacticDinerGuide.RestaurantCustomers.Actions.{Get, Update}
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer

  @doc """
  Soft undeletes a restaurant_customer with the given id.
  """
  @spec call(binary()) :: {:ok, RestaurantCustomer.t()} | {:error, Error.t()}
  def call(id) do
    attrs = %{
      deleted_at: nil,
      is_enabled: true
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
