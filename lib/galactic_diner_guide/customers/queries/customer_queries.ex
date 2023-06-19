defmodule GalacticDinerGuide.Customers.Queries.CustomerQueries do
  @moduledoc """
  Queries for the customers table.
  """
  import Ecto.Query

  alias GalacticDinerGuide.Customers.Models.Customer
  alias GalacticDinerGuide.Restaurants.Models.Restaurant

  @doc """
  Count how many customers there are in database.
  """
  @spec count_total_customers :: integer()
  def count_total_customers do
    from(c in Customer,
      select: count(c.id)
    )
  end

  @doc """
  Get the customer who visited the most restaurants overall.
  """
  @spec get_most_frequent_customer_overall :: tuple()
  def get_most_frequent_customer_overall do
    from(c in Customer,
      group_by: c.first_name,
      order_by: [desc: count(c.first_name)],
      select: {c.first_name, count(c.first_name)},
      limit: 1
    )
  end

  @doc """
  Get the customer who visited the most each restaurant.
  """
  @spec most_frequent_customer_per_restaurant(String.t()) :: tuple()
  def most_frequent_customer_per_restaurant(restaurant_name) do
    from(c in Customer,
      join: rc in assoc(c, :restaurant_customer),
      join: r in Restaurant,
      on: rc.restaurant_id == r.id,
      where: r.restaurant_name == ^restaurant_name,
      group_by: c.first_name,
      select: %{first_name: c.first_name, count: count(c.first_name)},
      order_by: [desc: count(c.first_name)],
      limit: 1
    )
  end
end
