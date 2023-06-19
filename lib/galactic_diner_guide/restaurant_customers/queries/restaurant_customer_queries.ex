defmodule GalacticDinerGuide.RestaurantCustomers.Queries.RestaurantCustomerQueries do
  @moduledoc """
  Queries for the restaurant customers table.
  """
  import Ecto.Query

  alias GalacticDinerGuide.Customers.Models.Customer
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer
  alias GalacticDinerGuide.Restaurants.Models.Restaurant

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

  @doc """
  Updates all customer_ids; does not update the values dinamically
  """
  @spec update_all_customer_ids() :: :ok
  def update_all_customer_ids() do
    from rc in RestaurantCustomer,
      inner_join: r in Restaurant,
      on: rc.restaurant_id == r.id,
      inner_join: c in Customer,
      on: rc.restaurant_id == r.id,
      where: is_nil(rc.customer_id),
      update: [set: [customer_id: c.id]]
  end
end
