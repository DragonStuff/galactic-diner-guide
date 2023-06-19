defmodule GalacticDinerGuide.RestaurantCustomers.Actions.UpdateTest do
  use GalacticDinerGuide.DataCase, async: true

  alias GalacticDinerGuide.{Error, Factory}
  alias GalacticDinerGuide.RestaurantCustomers.Actions.Update
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer

  describe "call/1" do
    test "with an existing id, updates the register on database" do
      %{id: customer_id} = Factory.insert(:customer)
      %{id: restaurant_id} = Factory.insert(:restaurant)

      %{id: restaurant_customer_id} =
        Factory.insert(:restaurant_customer,
          customer_id: customer_id,
          restaurant_id: restaurant_id
        )

      attrs = %{restaurant_id: "016c82c7-0fbc-4737-a45e-c5229c6015aa"}

      response = Update.call(restaurant_customer_id, attrs)

      assert {:ok,
              %RestaurantCustomer{
                id: restaurant_customer_id,
                restaurant_id: "016c82c7-0fbc-4737-a45e-c5229c6015aa"
              }} = response
    end

    test "when the id does not exist, returns an error" do
      %{id: customer_id} = Factory.insert(:customer)
      %{id: restaurant_id} = Factory.insert(:restaurant)

      %{id: _restaurant_customer_id} =
        Factory.insert(:restaurant_customer,
          customer_id: customer_id,
          restaurant_id: restaurant_id
        )

      attrs = %{restaurant_id: "016c82c7-0fbc-4737-a45e-c5229c6015aa"}

      random_id = UUID.uuid4()

      response = Update.call(random_id, attrs)

      expected_response =
        {:error, %Error{result: "RestaurantCustomer not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
