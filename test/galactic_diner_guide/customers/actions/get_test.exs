defmodule GalacticDinerGuide.Customers.Actions.GetTest do
  use GalacticDinerGuide.DataCase, async: true

  alias GalacticDinerGuide.{Error, Factory}
  alias GalacticDinerGuide.Customers.Actions.Get
  alias GalacticDinerGuide.Customers.Models.Customer

  describe "call/1" do
    test "with an existing id, fetches the register on database" do
      %Customer{id: id} = Factory.insert(:customer)

      response = Get.call(id)

      assert {:ok, %Customer{id: id}} = response
    end

    test "when the id does not exist, returns an error" do
      Factory.insert(:customer)

      bad_id = "f41eba45-c503-4680-90d9-3ba3c7e0389f"

      response = Get.call(bad_id)

      expected_response = {:error, %Error{status: :not_found, result: "Customer not found"}}

      assert response == expected_response
    end
  end
end
