defmodule GalacticDinerGuide.RestaurantCustomers.Actions.CreateTest do
  use GalacticDinerGuide.DataCase

  alias GalacticDinerGuide.{Error, Factory}
  alias GalacticDinerGuide.RestaurantCustomers.Actions.Create
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer

  describe "call/1" do
    test "when all params are valid, saves the restaurant_customer in database" do
      %{id: customer_id} = Factory.insert(:customer)
      %{id: restaurant_id} = Factory.insert(:restaurant)

      params =
        Factory.build(:restaurant_customer_params,
          customer_id: customer_id,
          restaurant_id: restaurant_id
        )

      response = Create.call(params)

      assert %RestaurantCustomer{restaurant_id: restaurant_id, customer_id: customer_id} =
               response
    end

    test "when some required field is nil, returns an error" do
      %{id: _customer_id} = Factory.insert(:customer)
      %{id: restaurant_id} = Factory.insert(:restaurant)

      params =
        Factory.build(:restaurant_customer_params, customer_id: nil, restaurant_id: restaurant_id)

      response = Create.call(params)

      assert {:error,
              %Error{
                status: :bad_request,
                result: %Ecto.Changeset{
                  action: :insert,
                  errors: [customer_id: {"can't be blank", [validation: :required]}],
                  data: %RestaurantCustomer{},
                  valid?: false
                }
              }} = response
    end
  end
end
