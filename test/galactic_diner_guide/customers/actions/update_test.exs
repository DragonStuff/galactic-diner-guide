defmodule GalacticDinerGuide.Customers.Actions.UpdateTest do
  use GalacticDinerGuide.DataCase, async: true

  alias GalacticDinerGuide.{Error, Factory}
  alias GalacticDinerGuide.Customers.Actions.Update
  alias GalacticDinerGuide.Customers.Models.Customer

  describe "call/1" do
    test "with an existing id, updates the register on database" do
      %{id: customer_id} = Factory.insert(:customer)

      attrs = %{first_name: "Tokyo Tales"}

      response = Update.call(customer_id, attrs)

      assert {:ok, %Customer{id: customer_id, first_name: "Tokyo Tales"}} = response
    end

    test "when the id does not exist, returns an error" do
      %{id: _customer_id} = Factory.insert(:customer)

      attrs = %{first_name: "Tokyo Tales"}

      random_id = UUID.uuid4()

      response = Update.call(random_id, attrs)

      expected_response = {:error, %Error{result: "Customer not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
