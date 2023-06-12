defmodule GalacticDinerGuide.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: GalacticDinerGuide.Repo

  alias GalacticDinerGuide.Customers.Models.Customer
  alias GalacticDinerGuide.Items.Models.Item
  alias GalacticDinerGuide.Restaurants.Models.Restaurant
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer

  def restaurant_visitors_query do
    """
    {getVisitorsPerRestaurant(restaurantName: "the-ice-cream-parlor")
    {visitors}}
    """
  end

  def restaurant_popular_food do
    """
    {getMostPopularFoodPerRestaurant(restaurantName: "the-ice-cream-parlor")
    {mostPopularFood}}
    """
  end

  def customer_params_factory do
    %{
      first_name: "John",
      is_enabled: true
    }
  end

  def customer_factory do
    %Customer{
      id: uuid(),
      first_name: "Selma",
      is_enabled: true
    }
  end

  def item_params_factory do
    %{
      id: uuid(),
      food_name: "Pizza",
      food_cost: 10.99,
      restaurant_customer_id: 62
    }
  end

  def item_factory do
    %Item{
      id: uuid(),
      food_name: "Sushi",
      food_cost: 18.99,
      restaurant_customer_id: 68
    }
  end

  def restaurant_params_factory do
    %{
      id: uuid(),
      restaurant_name: "Galactic Diner",
      is_enabled: true
    }
  end

  def restaurant_factory do
    %Restaurant{
      id: uuid(),
      restaurant_name: "Truly faster than light",
      is_enabled: true
    }
  end

  def restaurant_customer_params_factory do
    %{
      id: uuid(),
      restaurant_id: uuid(),
      customer_id: uuid()
    }
  end

  def restaurant_customer_factory do
    %RestaurantCustomer{
      id: uuid(),
      restaurant_id: uuid(),
      customer_id: uuid()
    }
  end

  defp uuid, do: UUID.uuid4()
end
