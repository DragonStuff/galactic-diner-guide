defmodule GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomerTest do
  use GalacticDinerGuide.DataCase

  alias Ecto.Changeset

  alias GalacticDinerGuide.Factory
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer
  alias GalacticDinerGuide.Items.Models.Item

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      %{id: customer_id} = Factory.insert(:customer)
      %{id: restaurant_id} = Factory.insert(:restaurant)

      params =
        Factory.build(:restaurant_customer_params,
          customer_id: customer_id,
          restaurant_id: restaurant_id
        )

      rc_id = params.id

      Factory.insert(:item, restaurant_customer_id: rc_id)

      params
      |> RestaurantCustomer.changeset()
      |> Ecto.Changeset.cast_assoc(:item, with: &Item.changeset/2)

      assert %Ecto.Changeset{changes: params, valid?: true}
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      %{id: customer_id} = Factory.insert(:customer)
      %{id: restaurant_id} = Factory.insert(:restaurant)

      params =
        Factory.build(:restaurant_customer_params,
          customer_id: customer_id,
          restaurant_id: restaurant_id
        )

      random_id = UUID.uuid4()

      Factory.insert(:item, restaurant_customer_id: params.id)

      attrs = %{restaurant_id: random_id}

      params
      |> RestaurantCustomer.changeset()
      |> RestaurantCustomer.changeset(attrs)
      |> Ecto.Changeset.cast_assoc(:item, with: &Item.changeset/2)

      assert %Changeset{changes: %{restaurant_id: random_id}, valid?: true}
    end

    test "when there's an error, returns an invalid changeset" do
      Factory.insert(:customer)
      %{id: restaurant_id} = Factory.insert(:restaurant)

      params =
        Factory.build(:restaurant_customer_params,
          customer_id: nil,
          restaurant_id: restaurant_id
        )

      Factory.insert(:item, restaurant_customer_id: params.id)

      response =
        params
        |> RestaurantCustomer.changeset()
        |> Ecto.Changeset.cast_assoc(:item, with: &Item.changeset/2)

      expected_response = %{customer_id: ["can't be blank"]}

      assert errors_on(response) == expected_response
    end
  end

  describe "build/1" do
    test "when all params are valid, returns a valid struct" do
      %{id: customer_id} = Factory.insert(:customer)
      %{id: restaurant_id} = Factory.insert(:restaurant)

      params =
        Factory.build(:restaurant_customer_params,
          customer_id: customer_id,
          restaurant_id: restaurant_id
        )

      rc_id = params.id

      Factory.insert(:item, restaurant_customer_id: rc_id)

      params
      |> RestaurantCustomer.changeset()
      |> Ecto.Changeset.cast_assoc(:item, with: &Item.changeset/2)

      assert %Ecto.Changeset{changes: params, valid?: true}
    end

    test "when updating a changeset, returns a struct with the given changes" do
      %{id: customer_id} = Factory.insert(:customer)
      %{id: restaurant_id} = Factory.insert(:restaurant)

      params =
        Factory.build(:restaurant_customer_params,
          customer_id: customer_id,
          restaurant_id: restaurant_id
        )

      random_id = UUID.uuid4()

      Factory.insert(:item, restaurant_customer_id: params.id)

      attrs = %{restaurant_id: random_id}

      params
      |> RestaurantCustomer.changeset()
      |> RestaurantCustomer.changeset(attrs)
      |> Ecto.Changeset.cast_assoc(:item, with: &Item.changeset/2)

      assert %Changeset{changes: %{restaurant_id: random_id}, valid?: true}
    end

    test "when there's an error, returns an invalid struct" do
      Factory.insert(:customer)
      %{id: restaurant_id} = Factory.insert(:restaurant)

      params =
        Factory.build(:restaurant_customer_params,
          customer_id: nil,
          restaurant_id: restaurant_id
        )

      Factory.insert(:item, restaurant_customer_id: params.id)

      response =
        params
        |> RestaurantCustomer.changeset()
        |> Ecto.Changeset.cast_assoc(:item, with: &Item.changeset/2)

      expected_response = %{customer_id: ["can't be blank"]}

      assert errors_on(response) == expected_response
    end
  end
end
