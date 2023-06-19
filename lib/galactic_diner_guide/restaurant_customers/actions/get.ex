defmodule GalacticDinerGuide.RestaurantCustomers.Actions.Get do
  @moduledoc """
  Gets an RestaurantCustomer from database.
  """
  alias GalacticDinerGuide.{Error, Repo}
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer

  @doc """
  Gets a restaurant_customer from database with the given id.
  """
  @spec call(binary()) :: {:ok, RestaurantCustomer.t()} | {:error, Error.t()}
  def call(id) do
    case Repo.get(RestaurantCustomer, id) do
      nil -> {:error, Error.build_order_not_found_error()}
      restaurant_customer -> {:ok, restaurant_customer}
    end
  end
end
