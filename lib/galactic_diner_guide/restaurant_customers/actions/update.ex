defmodule GalacticDinerGuide.RestaurantCustomers.Actions.Update do
  @moduledoc """
  Updates an restaurant_customer from database.
  """
  alias GalacticDinerGuide.{Error, Repo}
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer

  @doc """
  Updates a restaurant_customer from database with the given attributes.
  """
  @spec call(binary(), map()) :: {:ok, RestaurantCustomer.t()} | {:error, Error.t()}
  def call(id, attrs) do
    case Repo.get(RestaurantCustomer, id) do
      nil -> {:error, Error.build_order_not_found_error()}
      order -> do_update(order, attrs)
    end
  end

  defp do_update(order, attrs) do
    order
    |> RestaurantCustomer.changeset(attrs)
    |> Repo.update()
  end
end
