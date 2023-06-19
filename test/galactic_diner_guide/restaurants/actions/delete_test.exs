defmodule GalacticDinerGuide.Restaurants.Actions.DeleteTest do
  use GalacticDinerGuide.DataCase, async: true

  alias GalacticDinerGuide.{Error, Factory}
  alias GalacticDinerGuide.Restaurants.Actions.Delete
  alias GalacticDinerGuide.Restaurants.Models.Restaurant

  describe "call/1" do
    test "with an existing id, soft deletes the register on database" do
      %{id: restaurant_id} = Factory.insert(:restaurant)

      response = Delete.call(restaurant_id)

      assert {
               :ok,
               %Restaurant{
                 id: restaurant_id,
                 restaurant_name: "Truly faster than light",
                 is_enabled: false
               }
             } = response
    end

    test "when the ID doesn't exist, returns an error" do
      %{id: _restaurant_id} = Factory.insert(:restaurant)

      random_id = UUID.uuid4()

      response = Delete.call(random_id)

      assert {:error, %Error{result: "Restaurant not found", status: :not_found}} == response
    end
  end
end
