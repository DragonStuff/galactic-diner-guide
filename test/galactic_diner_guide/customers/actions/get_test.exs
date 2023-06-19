defmodule GalacticDinerGuide.Customers.Actions.GetTest do
  use GalacticDinerGuide.DataCase, async: true

  alias GalacticDinerGuide.{Error, Factory}
  alias GalacticDinerGuide.Customers.Actions.Get
  alias GalacticDinerGuide.Customers.Models.Customer

  describe "call/1" do
    test "with an existing id, fetches the register on database" do
      %{id: id} = Factory.insert(:customer)

      response = Get.call(id)

      assert {:ok,
              %Customer{
                id: id,
                first_name: "Selma",
                is_enabled: true
              }} = response
    end

    test "when the id does not exist, returns an error" do
      %{id: _id} = Factory.insert(:customer)

      random_id = UUID.uuid4()

      response = Get.call(random_id)

      expected_response = {:error, %Error{result: "Customer not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
