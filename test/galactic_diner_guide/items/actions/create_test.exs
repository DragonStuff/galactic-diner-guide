defmodule GalacticDinerGuide.Items.Actions.CreateTest do
  use GalacticDinerGuide.DataCase

  alias GalacticDinerGuide.{Error, Factory}
  alias GalacticDinerGuide.Items.Actions.Create
  alias GalacticDinerGuide.Items.Models.Item

  describe "call/1" do
    test "when all params are valid, saves the customer in database" do
      %{id: restaurant_id} = Factory.insert(:restaurant)
      %{id: customer_id} = Factory.insert(:customer)

      %{id: order_id} =
        Factory.insert(:restaurant_customer,
          customer_id: customer_id,
          restaurant_id: restaurant_id
        )

      params = Factory.build(:item_params, restaurant_customer_id: order_id)

      response = Create.call(params)

      assert %Item{food_name: "Pizza", food_cost: 10.99} = response
    end

    test "when some required field is nil, returns an error" do
      %{id: restaurant_id} = Factory.insert(:restaurant)
      %{id: customer_id} = Factory.insert(:customer)

      %{id: order_id} =
        Factory.insert(:restaurant_customer,
          customer_id: customer_id,
          restaurant_id: restaurant_id
        )

      params = Factory.build(:item_params, restaurant_customer_id: order_id, food_name: nil)

      response = Create.call(params)

      assert {:error,
              %Error{
                status: :bad_request,
                result: %Ecto.Changeset{
                  action: :insert,
                  errors: [food_name: {"can't be blank", [validation: :required]}],
                  data: %Item{},
                  valid?: false
                }
              }} = response
    end

    test "when food_name has more than 100 chars, returns an error" do
      %{id: restaurant_id} = Factory.insert(:restaurant)
      %{id: customer_id} = Factory.insert(:customer)

      %{id: order_id} =
        Factory.insert(:restaurant_customer,
          customer_id: customer_id,
          restaurant_id: restaurant_id
        )

      really_great_string =
        "Picture yourself hitchhiking through space, clutching your trusty towel, the universal symbol of preparedness and a handy tool for any unexpected intergalactic situation. Whether it's engaging in interdimensional chess matches, conversing with depressed robots, or sipping Pan Galactic Gargle Blasters, prepare yourself for a wild ride of cosmic proportions."

      params =
        Factory.build(:item_params,
          restaurant_customer_id: order_id,
          food_name: really_great_string
        )

      response = Create.call(params)

      assert {:error,
              %Error{
                status: :bad_request,
                result: %Ecto.Changeset{
                  action: :insert,
                  errors: [
                    food_name:
                      {"should be at most %{count} character(s)",
                       [count: 100, validation: :length, kind: :max, type: :string]}
                  ],
                  data: %Item{},
                  valid?: false
                }
              }} = response
    end
  end
end
