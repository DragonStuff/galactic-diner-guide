defmodule GalacticDinerGuideWeb.Graphql.Resolvers.Restaurant do
  alias GalacticDinerGuide.Error

  alias GalacticDinerGuide.Restaurants.Actions.{
    Get,
    GetMostProfitableFoodPerRestaurant,
    GetMostPopularFoodPerRestaurant,
    GetMostVisited,
    GetProfitPerRestaurant,
    GetVisitorsPerRestaurant
  }

  def get_visitors_per_restaurant(%{restaurant_name: restaurant_name}, _conn) do
    case GetVisitorsPerRestaurant.call(restaurant_name) do
      {:ok, total_visitors} -> {:ok, %{visitors: total_visitors}}
      {:error, _} -> {:error, Error.build_bad_request_error()}
    end
  end

  def get_profit_per_restaurant(%{restaurant_name: restaurant_name}, _conn) do
    case GetProfitPerRestaurant.call(restaurant_name) do
      {:ok, total_profit} -> {:ok, %{total_profit: total_profit}}
      {:error, _} -> {:error, Error.build_bad_request_error()}
    end
  end

  def get_most_popular_food_per_restaurant(%{restaurant_name: restaurant_name}, _conn) do
    case GetMostPopularFoodPerRestaurant.call(restaurant_name) do
      {:ok, most_popular_food} -> {:ok, %{most_popular_food: most_popular_food}}
      {:error, _} -> {:error, Error.build_bad_request_error()}
    end
  end

  def get_most_profitable_food_per_restaurant(%{restaurant_name: restaurant_name}, _conn) do
    case GetMostProfitableFoodPerRestaurant.call(restaurant_name) do
      {:ok, most_lucrative_food} -> {:ok, %{most_lucrative_food: most_lucrative_food}}
      {:error, _} -> {:error, Error.build_bad_request_error()}
    end
  end

  def get_most_visited(_args, _conn) do
    case GetMostVisited.call() do
      {:ok, most_visited} -> {:ok, %{most_visited: most_visited}}
      {:error, _} -> {:error, Error.build_bad_request_error()}
    end
  end

  def get_restaurant(%{id: id}, _conn), do: Get.call(id)
end
