defmodule GalacticDinerGuide.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: GalacticDinerGuide.Repo

  alias GalacticDinerGuide.Customers.Models.Customer
  alias GalacticDinerGuide.Items.Models.Item
  alias GalacticDinerGuide.Restaurants.Models.Restaurant
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer

  def customer_params_factory do
    %{
      id: uuid(),
      first_name: "John",
      is_enabled: true,
      inserted_at: now(),
      updated_at: now(),
      deleted_at: nil
    }
  end

  def customer_factory do
    %Customer{
      id: uuid(),
      first_name: "Selma",
      is_enabled: true,
      inserted_at: now(),
      updated_at: now(),
      deleted_at: nil
    }
  end

  def item_params_factory do
    %{
      id: uuid(),
      food_name: "Pizza",
      food_cost: 10.99,
      restaurant_customer_id: uuid(),
      inserted_at: now(),
      updated_at: now(),
      deleted_at: nil
    }
  end

  def item_factory do
    %Item{
      id: uuid(),
      food_name: "Sushi",
      food_cost: 18.99,
      restaurant_customer_id: uuid(),
      inserted_at: now(),
      updated_at: now(),
      deleted_at: nil
    }
  end

  def restaurant_params_factory do
    %{
      id: uuid(),
      restaurant_name: "Galactic Diner",
      is_enabled: true,
      inserted_at: now(),
      updated_at: now(),
      deleted_at: nil
    }
  end

  def restaurant_factory do
    %Restaurant{
      id: uuid(),
      restaurant_name: "Truly faster than light",
      is_enabled: true,
      inserted_at: now(),
      updated_at: now(),
      deleted_at: nil
    }
  end

  def restaurant_customer_params_factory do
    %{
      id: uuid(),
      restaurant_id: uuid(),
      customer_id: uuid(),
      inserted_at: now(),
      updated_at: now(),
      deleted_at: nil
    }
  end

  def restaurant_customer_factory do
    %RestaurantCustomer{
      id: uuid(),
      restaurant_id: uuid(),
      customer_id: uuid(),
      inserted_at: now(),
      updated_at: now(),
      deleted_at: nil
    }
  end

  defp now, do: DateTime.utc_now()
  defp uuid, do: UUID.uuid4()
end
