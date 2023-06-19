defmodule GalacticDinerGuide.Items.Actions.UpdateTest do
  use GalacticDinerGuide.DataCase, async: true

  alias GalacticDinerGuide.{Error, Factory}
  alias GalacticDinerGuide.Items.Actions.Update
  alias GalacticDinerGuide.Items.Models.Item

  describe "call/1" do
    test "with an existing id, updates the register on database" do
      %{id: restaurant_id} = Factory.insert(:restaurant)
      %{id: customer_id} = Factory.insert(:customer)

      %{id: order_id} =
        Factory.insert(:restaurant_customer,
          customer_id: customer_id,
          restaurant_id: restaurant_id
        )

      %{id: item_id} =
        Factory.insert(:item,
          restaurant_customer_id: order_id,
          food_name: "Tea",
          is_enabled: false
        )

      attrs = %{food_name: "Tiramisu"}

      response = Update.call(item_id, attrs)

      assert {:ok, %Item{id: item_id, food_name: "Tiramisu"}} = response
    end

    test "when the id does not exist, returns an error" do
      %{id: restaurant_id} = Factory.insert(:restaurant)
      %{id: customer_id} = Factory.insert(:customer)

      %{id: order_id} =
        Factory.insert(:restaurant_customer,
          customer_id: customer_id,
          restaurant_id: restaurant_id
        )

      %{id: _item_id} =
        Factory.insert(:item,
          restaurant_customer_id: order_id,
          food_name: "Tea",
          is_enabled: false
        )

      attrs = %{food_name: "Coffee"}

      random_id = UUID.uuid4()

      response = Update.call(random_id, attrs)

      expected_response = {:error, %Error{result: "Item not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
