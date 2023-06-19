defmodule GalacticDinerGuide.Restaurants.Actions.CreateTest do
  use GalacticDinerGuide.DataCase

  alias GalacticDinerGuide.{Error, Factory}
  alias GalacticDinerGuide.Restaurants.Actions.Create
  alias GalacticDinerGuide.Restaurants.Models.Restaurant

  describe "call/1" do
    test "when all params are valid, saves the customer in database" do
      params = Factory.build(:restaurant_params)

      response = Create.call(params)

      assert %Restaurant{restaurant_name: "Galactic Diner"} = response
    end

    test "when some required field is nil, returns an error" do
      params = Factory.build(:restaurant_params, restaurant_name: nil)

      response = Create.call(params)

      assert {:error,
              %Error{
                status: :bad_request,
                result: %Ecto.Changeset{
                  action: :insert,
                  errors: [restaurant_name: {"can't be blank", [validation: :required]}],
                  data: %Restaurant{},
                  valid?: false
                }
              }} = response
    end

    test "when restaurant_name has more than 100 chars, returns an error" do
      really_great_string =
        "Picture yourself hitchhiking through space, clutching your trusty towel, the universal symbol of preparedness and a handy tool for any unexpected intergalactic situation. Whether it's engaging in interdimensional chess matches, conversing with depressed robots, or sipping Pan Galactic Gargle Blasters, prepare yourself for a wild ride of cosmic proportions."

      params = Factory.build(:restaurant_params, restaurant_name: really_great_string)

      response = Create.call(params)

      assert {:error,
              %Error{
                status: :bad_request,
                result: %Ecto.Changeset{
                  action: :insert,
                  errors: [
                    restaurant_name:
                      {"should be at most %{count} character(s)",
                       [count: 100, validation: :length, kind: :max, type: :string]}
                  ],
                  data: %Restaurant{},
                  valid?: false
                }
              }} = response
    end
  end
end
