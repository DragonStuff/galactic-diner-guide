defmodule GalacticDinerGuide.RestaurantCustomers.Queries.RestaurantCustomerQueries do
  @moduledoc """
  Queries for the restaurant customers table.
  """
  import Ecto.Query

  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer

  @doc """
  Query for restaurant_customers tables
  """
  @spec query :: Ecto.Query.t()
  def query do
    from(rc in RestaurantCustomer)
  end

  @doc """
  Count how many restaurant_customers (orders) there are in database.
  """
  @spec count_total_restaurant_customers :: integer()
  def count_total_restaurant_customers do
    query()
    |> select([rc], count(rc.id))
  end

  @doc """
  Count how many restaurant_customers (orders) there are in database.
  Receives a list of restaurant ids.
  """
  @spec get_all_restaurant_customer_ids_by_restaurant_id(list()) :: list()
  def get_all_restaurant_customer_ids_by_restaurant_id(restaurant_ids) do
    query()
    |> where([rc], rc.restaurant_id in ^restaurant_ids)
    |> select([rc], rc.id)
  end
end
