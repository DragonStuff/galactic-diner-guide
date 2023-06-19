defmodule GalacticDinerGuide.Customers.Models.CustomerTest do
  use GalacticDinerGuide.DataCase

  alias Ecto.Changeset
  alias GalacticDinerGuide.Factory

  alias GalacticDinerGuide.Customers.Models.Customer
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = Factory.build(:customer_params)

      response =
        params
        |> Customer.changeset()
        |> Ecto.Changeset.cast_assoc(:restaurant_customer, with: &RestaurantCustomer.changeset/2)

      assert %Changeset{changes: %{first_name: "John"}, valid?: true} = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = Factory.build(:customer_params)

      attrs = %{first_name: "John"}

      response =
        params
        |> Customer.changeset()
        |> Customer.changeset(attrs)
        |> Ecto.Changeset.cast_assoc(:restaurant_customer, with: &RestaurantCustomer.changeset/2)

      assert %Changeset{changes: %{first_name: "John"}, valid?: true} = response
    end

    test "when there's an error, returns an invalid changeset" do
      params = Factory.params_for(:customer_params, first_name: nil)

      response =
        params
        |> Customer.changeset()
        |> Ecto.Changeset.cast_assoc(:restaurant_customer, with: &RestaurantCustomer.changeset/2)

      expected_response = %{first_name: ["can't be blank"]}

      assert errors_on(response) == expected_response
    end
  end

  describe "build/1" do
    test "when all params are valid, returns a valid struct" do
      params = Factory.build(:customer_params)

      response =
        params
        |> Customer.changeset()
        |> Ecto.Changeset.cast_assoc(:restaurant_customer, with: &RestaurantCustomer.changeset/2)

      assert %Changeset{changes: %{first_name: "John"}, valid?: true} = response
    end

    test "when updating a changeset, returns a struct with the given changes" do
      params = Factory.build(:customer_params)

      attrs = %{first_name: "John"}

      response =
        params
        |> Customer.changeset()
        |> Customer.changeset(attrs)
        |> Ecto.Changeset.cast_assoc(:restaurant_customer, with: &RestaurantCustomer.changeset/2)

      assert %Changeset{changes: %{first_name: "John"}, valid?: true} = response
    end

    test "when there's an error, returns an invalid struct" do
      params = Factory.params_for(:customer_params, first_name: nil)

      response =
        params
        |> Customer.changeset()
        |> Ecto.Changeset.cast_assoc(:restaurant_customer, with: &RestaurantCustomer.changeset/2)

      expected_response = %{first_name: ["can't be blank"]}

      assert errors_on(response) == expected_response
    end
  end
end
