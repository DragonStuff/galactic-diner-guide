defmodule GalacticDinerGuide.Restaurants.Models.RestaurantTest do
  use GalacticDinerGuide.DataCase

  alias Ecto.Changeset
  alias GalacticDinerGuide.Factory

  alias GalacticDinerGuide.Restaurants.Models.Restaurant
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = Factory.build(:restaurant_params)

      params
      |> Restaurant.changeset()
      |> Ecto.Changeset.cast_assoc(:restaurant_customer, with: &RestaurantCustomer.changeset/2)

      assert %Changeset{
        changes: %{restaurant_name: "Galactic Diner"},
        valid?: true,
        action: :insert
      }
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = Factory.build(:restaurant_params)

      attrs = %{restaurant_name: "Forty Two"}

      params
      |> Restaurant.changeset()
      |> Restaurant.changeset(attrs)
      |> Ecto.Changeset.cast_assoc(:restaurant_customer, with: &RestaurantCustomer.changeset/2)

      assert %Changeset{changes: %{restaurant_name: "Forty Two"}, valid?: true, action: :insert}
    end

    test "when there's an error, returns an invalid changeset" do
      params = Factory.build(:restaurant_params, restaurant_name: nil)

      response =
        params
        |> Restaurant.changeset()
        |> Ecto.Changeset.cast_assoc(:restaurant_customer, with: &RestaurantCustomer.changeset/2)

      expected_response = %{restaurant_name: ["can't be blank"]}

      assert errors_on(response) == expected_response
    end
  end

  describe "build/1" do
    test "when all params are valid, returns a valid struct" do
      params = Factory.build(:restaurant_params)

      params
      |> Restaurant.changeset()
      |> Ecto.Changeset.cast_assoc(:restaurant_customer, with: &RestaurantCustomer.changeset/2)

      assert %Changeset{
        changes: %{restaurant_name: "Galactic Diner"},
        valid?: true,
        action: :insert
      }
    end

    test "when updating a changeset, returns struct with the given changes" do
      params = Factory.build(:restaurant_params)

      attrs = %{restaurant_name: "Forty Two"}

      params
      |> Restaurant.changeset()
      |> Restaurant.changeset(attrs)
      |> Ecto.Changeset.cast_assoc(:restaurant_customer, with: &RestaurantCustomer.changeset/2)

      assert %Changeset{changes: %{restaurant_name: "Forty Two"}, valid?: true, action: :insert}
    end

    test "when there's an error, returns an invalid struct" do
      params = Factory.build(:restaurant_params, restaurant_name: nil)

      response =
        params
        |> Restaurant.changeset()
        |> Ecto.Changeset.cast_assoc(:restaurant_customer, with: &RestaurantCustomer.changeset/2)

      expected_response = %{restaurant_name: ["can't be blank"]}

      assert errors_on(response) == expected_response
    end
  end
end
