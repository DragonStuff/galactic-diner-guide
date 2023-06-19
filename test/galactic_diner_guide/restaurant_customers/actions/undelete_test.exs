defmodule GalacticDinerGuide.RestaurantCustomers.Actions.UndeleteTest do
  use GalacticDinerGuide.DataCase, async: true

  alias GalacticDinerGuide.{Error, Factory}
  alias GalacticDinerGuide.RestaurantCustomers.Actions.Undelete
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer

  describe "call/1" do
    test "with an existing id, undeletes the register on database" do
      %{id: customer_id} = Factory.insert(:customer)
      %{id: restaurant_id} = Factory.insert(:restaurant)

      %{id: restaurant_customer_id} =
        Factory.insert(:restaurant_customer,
          customer_id: customer_id,
          restaurant_id: restaurant_id,
          is_enabled: false
        )

      response = Undelete.call(restaurant_customer_id)

      assert {
               :ok,
               %RestaurantCustomer{
                 id: restaurant_customer_id,
                 restaurant_id: restaurant_id,
                 customer_id: customer_id,
                 is_enabled: true
               }
             } = response
    end

    test "when the ID doesn't exist, returns an error" do
      %{id: customer_id} = Factory.insert(:customer)
      %{id: restaurant_id} = Factory.insert(:restaurant)

      %{id: _restaurant_customer_id} =
        Factory.insert(:restaurant_customer,
          customer_id: customer_id,
          restaurant_id: restaurant_id,
          is_enabled: false
        )

      random_id = UUID.uuid4()

      response = Undelete.call(random_id)

      expected_response =
        {:error, %Error{result: "RestaurantCustomer not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
