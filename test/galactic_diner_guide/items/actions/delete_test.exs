defmodule GalacticDinerGuide.Items.Actions.DeleteTest do
  use GalacticDinerGuide.DataCase, async: true

  alias GalacticDinerGuide.{Error, Factory}
  alias GalacticDinerGuide.Items.Actions.Delete
  alias GalacticDinerGuide.Items.Models.Item

  describe "call/1" do
    test "with an existing id, soft deletes the register on database" do
      %{id: restaurant_id} = Factory.insert(:restaurant)
      %{id: customer_id} = Factory.insert(:customer)

      %{id: order_id} =
        Factory.insert(:restaurant_customer,
          customer_id: customer_id,
          restaurant_id: restaurant_id
        )

      %{id: item_id} = Factory.insert(:item, restaurant_customer_id: order_id, is_enabled: true)

      response = Delete.call(item_id)

      assert {
               :ok,
               %Item{
                 id: item_id,
                 food_name: "Sushi",
                 food_cost: 18.99,
                 is_enabled: false
               }
             } = response
    end
  end

  test "when the ID doesn't exist, returns an error" do
    %{id: restaurant_id} = Factory.insert(:restaurant)
    %{id: customer_id} = Factory.insert(:customer)

    %{id: order_id} =
      Factory.insert(:restaurant_customer,
        customer_id: customer_id,
        restaurant_id: restaurant_id
      )

    %{id: item_id} = Factory.insert(:item, restaurant_customer_id: order_id)

    random_id = UUID.uuid4()

    response = Delete.call(random_id)

    assert {:error, %Error{result: "Item not found", status: :not_found}} == response
  end
end
