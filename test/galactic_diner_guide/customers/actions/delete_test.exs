defmodule GalacticDinerGuide.Customers.Actions.DeleteTest do
  use GalacticDinerGuide.DataCase, async: true

  alias GalacticDinerGuide.{Error, Factory, Repo}
  alias GalacticDinerGuide.Customers.Actions.Delete
  alias GalacticDinerGuide.Customers.Models.Customer
  alias GalacticDinerGuide.Items.Models.Item
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer
  alias GalacticDinerGuide.Restaurants.Models.Restaurant

  describe "call/1" do
    test "with an existing id, soft deletes the register on database" do
      %Customer{id: customer_id} = Factory.insert(:customer)

      %RestaurantCustomer{id: restaurant_customer_id} =
        Factory.insert(:restaurant_customer, customer_id: customer_id)

      response = Delete.call(customer_id)

      assert {
               :ok,
               %Customer{
                 id: customer_id,
                 first_name: "Selma",
                 is_enabled: false
               }
             } = response
    end

    test "when the register was already deleted, returns :bad_request; when the id was never registered in database, 
    returns an error :not_found" do
      %Customer{id: id} = Factory.insert(:customer)
      %Restaurant{id: restaurant_id} = Factory.insert(:restaurant)

      %RestaurantCustomer{id: rc_id} =
        Factory.insert(:restaurant_customer, customer_id: id, restaurant_id: restaurant_id)

      %Item{id: item_id} = Factory.insert(:item, restaurant_customer_id: rc_id)

      customer = Repo.get(Customer, id)

      case customer do
        nil ->
          response = Delete.call(id)
          expected_response = {:error, %Error{status: :bad_request, result: "Customer not found"}}
          assert response == expected_response

        %Customer{is_enabled: false} ->
          response = Delete.call(id)

          expected_response =
            {:error, %Error{status: :bad_request, result: "Record already deleted"}}

          assert response == expected_response

        _ ->
          Repo.preload(customer, :restaurant_customer)

          response = Delete.call(id)
          expected_response = {:ok, %{id: id}}

          assert response = expected_response
      end
    end
  end
end
