defmodule GalacticDinerGuide.Customers.Actions.UndeleteTest do
  use GalacticDinerGuide.DataCase, async: true

  alias GalacticDinerGuide.{Error, Factory}
  alias GalacticDinerGuide.Customers.Actions.Undelete
  alias GalacticDinerGuide.Customers.Models.Customer

  describe "call/1" do
    test "with an existing id, undeletes the register on database" do
      %{id: customer_id} = Factory.insert(:customer, is_enabled: false)
      Factory.insert(:restaurant_customer, customer_id: customer_id)

      response = Undelete.call(customer_id)

      assert {
               :ok,
               %Customer{
                 id: customer_id,
                 first_name: "Selma",
                 is_enabled: true
               }
             } = response
    end

    test "when the ID doesn't exist, returns an error" do
      %{id: customer_id} = Factory.insert(:customer, is_enabled: false)
      Factory.insert(:restaurant_customer, customer_id: customer_id)

      random_id = UUID.uuid4()

      response = Undelete.call(random_id)

      expected_response = {:error, %Error{result: "Customer not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
