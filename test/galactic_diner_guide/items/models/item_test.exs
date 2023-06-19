defmodule GalacticDinerGuide.Items.Models.ItemTest do
  use GalacticDinerGuide.DataCase

  alias Ecto.Changeset
  alias GalacticDinerGuide.Factory
  alias GalacticDinerGuide.Items.Models.Item

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      %{id: customer_id} = Factory.insert(:customer)
      %{id: restaurant_id} = Factory.insert(:restaurant)

      %{id: rc_id} =
        Factory.insert(:restaurant_customer,
          customer_id: customer_id,
          restaurant_id: restaurant_id
        )

      params = Factory.build(:item_params, restaurant_customer_id: rc_id)

      params
      |> Item.changeset()

      assert %Ecto.Changeset{changes: params, valid?: true}
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      %{id: customer_id} = Factory.insert(:customer)
      %{id: restaurant_id} = Factory.insert(:restaurant)

      %{id: rc_id} =
        Factory.insert(:restaurant_customer,
          customer_id: customer_id,
          restaurant_id: restaurant_id
        )

      params = Factory.build(:item_params, restaurant_customer_id: rc_id)

      food = "Pizza"

      attrs = %{food_name: food}

      params
      |> Item.changeset()
      |> Item.changeset(attrs)

      assert %Changeset{changes: %{food_name: food}, valid?: true}
    end

    test "when there's an error, returns an invalid changeset" do
      %{id: customer_id} = Factory.insert(:customer)
      %{id: restaurant_id} = Factory.insert(:restaurant)

      Factory.insert(:restaurant_customer,
        customer_id: customer_id,
        restaurant_id: restaurant_id
      )

      params = Factory.build(:item_params, restaurant_customer_id: nil)

      response =
        params
        |> Item.changeset()

      expected_response = %{restaurant_customer_id: ["can't be blank"]}

      assert errors_on(response) == expected_response
    end
  end

  describe "build/1" do
    test "when all params are valid, returns a valid struct" do
      %{id: customer_id} = Factory.insert(:customer)
      %{id: restaurant_id} = Factory.insert(:restaurant)

      %{id: rc_id} =
        Factory.insert(:restaurant_customer,
          customer_id: customer_id,
          restaurant_id: restaurant_id
        )

      params = Factory.build(:item_params, restaurant_customer_id: rc_id)

      params
      |> Item.changeset()

      assert %Ecto.Changeset{changes: params, valid?: true}
    end

    test "when updating a changeset, returns a struct with the given changes" do
      %{id: customer_id} = Factory.insert(:customer)
      %{id: restaurant_id} = Factory.insert(:restaurant)

      %{id: rc_id} =
        Factory.insert(:restaurant_customer,
          customer_id: customer_id,
          restaurant_id: restaurant_id
        )

      params = Factory.build(:item_params, restaurant_customer_id: rc_id)

      food = "Pizza"

      attrs = %{food_name: food}

      params
      |> Item.changeset()
      |> Item.changeset(attrs)

      assert %Changeset{changes: %{food_name: food}, valid?: true}
    end

    test "when updating a changeset, returns a valid changeset with the given struct" do
      %{id: customer_id} = Factory.insert(:customer)
      %{id: restaurant_id} = Factory.insert(:restaurant)

      %{id: rc_id} =
        Factory.insert(:restaurant_customer,
          customer_id: customer_id,
          restaurant_id: restaurant_id
        )

      params = Factory.build(:item_params, restaurant_customer_id: rc_id)

      food = "Pizza"

      attrs = %{food_name: food}

      params
      |> Item.changeset()
      |> Item.changeset(attrs)

      assert %Changeset{changes: %{food_name: food}, valid?: true}
    end

    test "when there's an error, returns an invalid changeset" do
      %{id: customer_id} = Factory.insert(:customer)
      %{id: restaurant_id} = Factory.insert(:restaurant)

      Factory.insert(:restaurant_customer,
        customer_id: customer_id,
        restaurant_id: restaurant_id
      )

      params = Factory.build(:item_params, restaurant_customer_id: nil)

      response =
        params
        |> Item.changeset()

      expected_response = %{restaurant_customer_id: ["can't be blank"]}

      assert errors_on(response) == expected_response
    end
  end
end
