defmodule GalacticDinerGuide.Restaurants.Actions.GetTest do
  use GalacticDinerGuide.DataCase, async: true

  alias GalacticDinerGuide.{Error, Factory}
  alias GalacticDinerGuide.Restaurants.Actions.Get
  alias GalacticDinerGuide.Restaurants.Models.Restaurant

  describe "call/1" do
    test "with an existing id, fetches the register on database" do
      %{id: id} = Factory.insert(:restaurant)

      response = Get.call(id)

      assert {:ok,
              %Restaurant{
                id: id,
                restaurant_name: "Truly faster than light",
                is_enabled: true
              }} = response
    end

    test "when the id does not exist, returns an error" do
      %{id: _id} = Factory.insert(:restaurant)

      random_id = UUID.uuid4()

      response = Get.call(random_id)

      expected_response = {:error, %Error{result: "Restaurant not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
