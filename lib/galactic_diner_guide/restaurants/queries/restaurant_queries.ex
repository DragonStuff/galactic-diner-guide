defmodule GalacticDinerGuide.Restaurants.Queries.RestaurantQueries do
  @moduledoc """
  Queries for the restaurants table.
  """
  import Ecto.Query

  alias GalacticDinerGuide.Repo
  alias GalacticDinerGuide.Items.Models.Item
  alias GalacticDinerGuide.Restaurants.Models.Restaurant
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer

  @doc """
  Query for Restaurants tables
  """
  @spec query :: Ecto.Query.t()
  def query do
    from(r in Restaurant)
  end

  @doc """
  Count how many restaurants there are in database.
  """
  @spec count_total_restaurants :: integer()
  def count_total_restaurants do
    query()
    |> select([r], count(r.id))
  end

  @doc """
  Count how many visitors an specific restaurant has received.
  """
  @spec count_visitors_per_restaurant(String.t()) :: integer()
  def count_visitors_per_restaurant(restaurant_name) do
    query()
    |> where([r], r.restaurant_name == ^restaurant_name)
    |> select([r], count(r.id))
  end

  @doc """
  Get all ids related to a specific restaurant_name.
  """
  @spec get_all_restaurant_ids_by_name(String.t()) :: list()
  def get_all_restaurant_ids_by_name(restaurant_name) do
    query()
    |> where([r], r.restaurant_name == ^restaurant_name)
    |> select([r], r.id)
  end

  def get_total_food_costs_by_restaurant_name(restaurant_name) do
    from(r in Restaurant,
      where: r.restaurant_name == ^restaurant_name,
      join: rc in assoc(r, :restaurant_customer),
      join: i in Item,
      where: i.restaurant_customer_id == rc.id,
      select: sum(i.food_cost)
    )
  end

  def get_popular_foods_for_all_restaurants do
    from(r in GalacticDinerGuide.Restaurants.Models.Restaurant,
      join: rc in assoc(r, :restaurant_customer),
      join: i in GalacticDinerGuide.Items.Models.Item,
      where: i.restaurant_customer_id == rc.id,
      group_by: [r.id, i.food_name],
      select: {r.restaurant_name, i.food_name, count(i.id)},
      order_by: [desc: count(i.id)],
      limit: 10
    )
  end

  def get_most_popular_food_by_restaurant(restaurant_name) do
    from(r in GalacticDinerGuide.Restaurants.Models.Restaurant,
      where: r.restaurant_name == ^restaurant_name,
      join: rc in assoc(r, :restaurant_customer),
      join: i in GalacticDinerGuide.Items.Models.Item,
      where: i.restaurant_customer_id == rc.id,
      group_by: [r.id, i.food_name],
      select: {i.food_name},
      order_by: [desc: count(i.id)]
    )
  end

  def most_profitable_dish_per_restaurant(restaurant_name) do
    from(r in Restaurant,
      where: r.restaurant_name == ^restaurant_name,
      join: i in assoc(r, :restaurant_customer),
      join: item in assoc(i, :items),
      group_by: r.id,
      select: {r.restaurant_name, max(item.food_cost)}
    )
  end

  def most_visited_restaurant do
    from r in GalacticDinerGuide.Restaurants.Models.Restaurant,
      join: rc in assoc(r, :restaurant_customer),
      join: c in GalacticDinerGuide.Customers.Models.Customer,
      on: rc.customer_id == c.id,
      group_by: r.restaurant_name,
      order_by: [desc: count(c.id)],
      select: {r.restaurant_name, count(c.id)}
  end
end
