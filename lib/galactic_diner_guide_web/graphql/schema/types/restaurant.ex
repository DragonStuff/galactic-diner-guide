defmodule GalacticDinerGuideWeb.Graphql.Schema.Types.Restaurant do
  @moduledoc """
  Graphql schema which deals with :restaurants table.
  """
  use Absinthe.Schema.Notation

  alias Crudry.Middlewares.TranslateErrors
  alias GalacticDinerGuideWeb.Graphql.Resolvers.Restaurant, as: RestaurantResolver

  object :restaurant do
    field :id, :id
    field :restaurant_name, :string
    field :visitors, :integer
    field :total_profit, :float
    field :most_popular_food, :string
    field :most_profitable_food_per_restaurant, :string
    field :get_restaurant, :string
  end

  object :restaurant_queries do
    @desc "Get total visitors per restaurant"
    field :get_visitors_per_restaurant, :restaurant do
      arg(:restaurant_name, :string)
      resolve &RestaurantResolver.get_visitors_per_restaurant/2
      middleware TranslateErrors
    end

    field :get_total_profit_per_restaurant, :restaurant do
      @desc "Get total profit per restaurant"
      arg(:restaurant_name, :string)
      resolve &RestaurantResolver.get_profit_per_restaurant/2
      middleware TranslateErrors
    end

    field :get_most_popular_food_per_restaurant, :restaurant do
      @desc "Get most popular food per restaurant"
      arg(:restaurant_name, :string)
      resolve &RestaurantResolver.get_most_popular_food_per_restaurant/2
      middleware TranslateErrors
    end

    field :get_most_profitable_food_per_restaurant, :restaurant do
      @desc "Get most profitable food per restaurant"
      arg(:restaurant_name, :string)
      resolve &RestaurantResolver.get_most_profitable_food_per_restaurant/2
      middleware TranslateErrors
    end

    field :get_restaurant_by_id, :restaurant do
      @desc "Returns a restaurant by its id"
      arg(:id, :id)
      arg(:restaurant_name, :string)
      resolve &RestaurantResolver.get_restaurant/2
      middleware TranslateErrors
    end
  end
end
