defmodule GalacticDinerGuide.Restaurants.Actions.UndeleteTest do
  use GalacticDinerGuide.DataCase, async: true

  alias GalacticDinerGuide.{Error, Factory}
  alias GalacticDinerGuide.Restaurants.Actions.Undelete
  alias GalacticDinerGuide.Restaurants.Models.Restaurant

  describe "call/1" do
    test "with an existing id, undeletes the register on database" do
      %{id: restaurant_id} = Factory.insert(:restaurant, is_enabled: false)
      Factory.insert(:restaurant_customer, restaurant_id: restaurant_id)

      response = Undelete.call(restaurant_id)

      assert {
               :ok,
               %Restaurant{
                 id: restaurant_id,
                 restaurant_name: "Truly faster than light",
                 is_enabled: true
               }
             } = response
    end

    test "when the ID doesn't exist, returns an error" do
      %{id: restaurant_id} = Factory.insert(:restaurant, is_enabled: false)
      Factory.insert(:restaurant_customer, restaurant_id: restaurant_id)

      random_id = UUID.uuid4()

      response = Undelete.call(random_id)

      expected_response = {:error, %Error{result: "Restaurant not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
