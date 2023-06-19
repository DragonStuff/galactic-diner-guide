defmodule GalacticDinerGuideWeb.Graphql.Resolvers.Restaurant do
@moduledoc """
Resolvers for :restaurants table.
"""
  alias GalacticDinerGuide.Restaurants.Actions.{
    Get,
    GetMostProfitableFoodPerRestaurant,
    GetMostPopularFoodPerRestaurant,
    GetProfitPerRestaurant,
    GetVisitorsPerRestaurant
  }

  def get_visitors_per_restaurant(%{restaurant_name: restaurant_name}, _conn) do
    {:ok, total_visitors} = GetVisitorsPerRestaurant.call(restaurant_name)

    case is_integer(total_visitors) do
      true ->
        {:ok, %{visitors: total_visitors}}

      false ->
        {:ok, %{visitors: "No visitors found"}}
    end
  end

  def get_profit_per_restaurant(%{restaurant_name: restaurant_name}, _conn) do
    {:ok, total_profit} = GetProfitPerRestaurant.call(restaurant_name)

    case is_float(total_profit) do
      true ->
        {:ok, %{total_profit: total_profit}}

      false ->
        {:ok, %{total_profit: 0}}
    end
  end

  def get_most_popular_food_per_restaurant(%{restaurant_name: restaurant_name}, _conn) do
    {:ok, most_popular_food} = GetMostPopularFoodPerRestaurant.call(restaurant_name)

    case is_bitstring(most_popular_food) do
      true ->
        {:ok, %{most_popular_food: most_popular_food}}

      false ->
        {:ok, %{most_popular_food: "No popular dishes found"}}
    end
  end

  def get_most_profitable_food_per_restaurant(%{restaurant_name: restaurant_name}, _conn) do
    {:ok, most_profitable_food} = GetMostProfitableFoodPerRestaurant.call(restaurant_name)

    case is_bitstring(most_profitable_food) do
      true ->
        {:ok, %{most_profitable_food_per_restaurant: most_profitable_food}}

      false ->
        {:ok, %{most_profitable_food_per_restaurant: "No profitable dishes found"}}
    end
  end

  def get_restaurant(%{id: id}, _conn), do: Get.call(id)
end
