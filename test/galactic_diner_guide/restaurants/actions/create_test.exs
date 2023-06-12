defmodule GalacticDinerGuide.Customers.Actions.CreateTest do
  use GalacticDinerGuide.DataCase, async: true

  alias GalacticDinerGuide.{Error, Factory}
  alias GalacticDinerGuide.Restaurants.Actions.Create
  alias GalacticDinerGuide.Items.Models.Item
  alias GalacticDinerGuide.Customers.Models.Customer
  alias GalacticDinerGuide.Restaurants.Models.Restaurant
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer

  describe "call/1" do
    test "when all params are valid, saves the customer in database" do
      params = Factory.build(:restaurant_params)

      response = Create.call(params)

      assert %Restaurant{restaurant_name: "Galactic Diner"} = response
    end

    test "when some required field is nil, returns an error" do
      %Customer{id: id} = Factory.insert(:customer)
      %Restaurant{id: restaurant_id} = Factory.insert(:restaurant)

      %RestaurantCustomer{id: rc_id} =
        Factory.insert(:restaurant_customer, customer_id: id, restaurant_id: restaurant_id)

      %Item{id: item_id} = Factory.insert(:item, restaurant_customer_id: rc_id)

      params = Factory.build(:restaurant_params, restaurant_name: nil)
      restaurant = Repo.get(Restaurant, id)

      case restaurant do
        nil ->
          response = Create.call(params)
          expected_response = {:error, %Error{status: :bad_request, result: "Restaurant not found"}}
          assert response = expected_response

        _ ->
          Repo.preload(restaurant, :restaurant_customer)

          response = Create.call(params)

          expected_response =
            {:error, %Error{status: :bad_request, result: %{restaurant_name: ["can't be blank"]}}}

          assert response = expected_response
      end
    end
  end
end
