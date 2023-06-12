defmodule GalacticDinerGuide.Customers.Models.CustomerTest do
  use GalacticDinerGuide.DataCase, async: true

  alias GalacticDinerGuide.Factory
  alias Ecto.Changeset
  alias GalacticDinerGuide.Customers.Models.Customer

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = Factory.build(:customer_params)

      response = Customer.changeset(params)

      assert %Changeset{changes: %{first_name: "John"}, valid?: true} = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = Factory.build(:customer_params)

      attrs = %{first_name: "John"}

      response =
        params
        |> Customer.changeset()
        |> Customer.changeset(attrs)

      assert %Changeset{changes: %{first_name: "John"}, valid?: true} = response
    end

    test "when there's an error, returns an invalid changeset" do
      params = Factory.build(:customer_params, first_name: nil)

      response = Customer.changeset(params)

      expected_response = %{first_name: ["can't be blank"]}

      assert errors_on(response) == expected_response
    end
  end
end
