defmodule GalacticDinerGuide.Restaurants.Actions.UpdateTest do
  use GalacticDinerGuide.DataCase, async: true

  alias GalacticDinerGuide.{Error, Factory}
  alias GalacticDinerGuide.Restaurants.Actions.Update
  alias GalacticDinerGuide.Restaurants.Models.Restaurant

  describe "call/1" do
    test "with an existing id, updates the register on database" do
      %{id: restaurant_id} = Factory.insert(:restaurant)

      attrs = %{restaurant_name: "Tokyo Tales"}

      response = Update.call(restaurant_id, attrs)

      assert {:ok, %Restaurant{id: restaurant_id, restaurant_name: "Tokyo Tales"}} = response
    end

    test "when the id does not exist, returns an error" do
      %{id: _restaurant_id} = Factory.insert(:restaurant)

      attrs = %{restaurant_name: "Tokyo Tales"}

      random_id = UUID.uuid4()

      response = Update.call(random_id, attrs)

      expected_response = {:error, %Error{result: "Restaurant not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
