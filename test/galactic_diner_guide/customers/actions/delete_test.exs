defmodule GalacticDinerGuide.Customers.Actions.DeleteTest do
  use GalacticDinerGuide.DataCase, async: true

  alias GalacticDinerGuide.{Error, Factory}
  alias GalacticDinerGuide.Customers.Actions.Delete
  alias GalacticDinerGuide.Customers.Models.Customer

  describe "call/1" do
    test "with an existing id, soft deletes the register on database" do
      %{id: customer_id} = Factory.insert(:customer)

      response = Delete.call(customer_id)

      assert {
               :ok,
               %Customer{
                 id: customer_id,
                 first_name: "Selma",
                 is_enabled: false
               }
             } = response
    end

    test "when the ID doesn't exist, returns an error" do
      %{id: _customer_id} = Factory.insert(:customer)

      random_id = UUID.uuid4()

      response = Delete.call(random_id)

      assert {:error, %Error{result: "Customer not found", status: :not_found}} == response
    end
  end
end
