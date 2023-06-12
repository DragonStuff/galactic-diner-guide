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

  def get_most_frequent_customer do
    from(c in Customer,
      join: rc in assoc(c, :restaurant_customer),
      join: r in Restaurant,
      on: rc.restaurant_id == r.id,
      group_by: c.id,
      order_by: [desc: count(r.id)],
      select: {c.id, count(r.id)}
    )
  end
end
