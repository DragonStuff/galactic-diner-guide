defmodule GalacticDinerGuideWeb.Graphql.Resolvers.RestaurantTest do
  use GalacticDinerGuideWeb.ConnCase

  alias GalacticDinerGuide.Factory

  @most_profitable_food_query """
  query getMostProfitableFoodPerRestaurant($restaurant_name: String!) {
      getMostProfitableFoodPerRestaurant(restaurantName: $restaurant_name) {
          mostProfitableFoodPerRestaurant
      }
  }
  """

  @total_earned_query """
  query getTotalProfitPerRestaurant($restaurant_name: String!) {
      getTotalProfitPerRestaurant(restaurantName: $restaurant_name) {
          totalProfit
      }
  }
  """

  @total_customers_query """
  query getVisitorsPerRestaurant($restaurant_name: String!) {
      getVisitorsPerRestaurant(restaurantName: $restaurant_name) {
          visitors
      }
  }
  """

  @most_popular_dish_query """
  query getMostPopularFoodPerRestaurant($restaurant_name: String!) {
      getMostPopularFoodPerRestaurant(restaurantName: $restaurant_name) {
          mostPopularFoodPerRestaurant
      }
  }
  """

  describe "get_most_profitable_food_per_restaurant/2" do
    test "returns the most profitable food per restaurant", %{conn: conn} do
      %{restaurant_name: restaurant_name, id: restaurant_id} = Factory.insert(:restaurant)
      %{id: customer_id} = Factory.insert(:customer)

      %{id: rc_id} =
        Factory.insert(:restaurant_customer,
          restaurant_id: restaurant_id,
          customer_id: customer_id
        )

      Factory.insert(:item, restaurant_customer_id: rc_id, food_name: "Lasagna")

      response =
        conn
        |> graphql(@most_profitable_food_query, %{restaurant_name: restaurant_name})
        |> json_response(200)
        |> Map.get("data")

      assert response == %{
               "getMostProfitableFoodPerRestaurant" => %{
                 "mostProfitableFoodPerRestaurant" => "Lasagna"
               }
             }
    end

    test "when the resolver is dealing with an error, the response is nil", %{conn: conn} do
      %{restaurant_name: restaurant_name, id: restaurant_id} = Factory.insert(:restaurant)

      %{id: customer_id} = Factory.insert(:customer)

      %{id: rc_id} =
        Factory.insert(:restaurant_customer,
          restaurant_id: restaurant_id,
          customer_id: customer_id
        )

      Factory.insert(:item, restaurant_customer_id: rc_id, food_name: "Lasagna")

      response =
        conn
        |> graphql(@most_profitable_food_query, %{error: "something's missing"})
        |> json_response(200)
        |> Map.get("data")

      assert response == nil
    end
  end

  describe "get_visitors_per_restaurant/2" do
    test "returns the total number of customers per restaurant", %{conn: conn} do
      %{restaurant_name: restaurant_name, id: restaurant_id} = Factory.insert(:restaurant)

      %{id: customer_id} = Factory.insert(:customer)

      %{id: rc_id} =
        Factory.insert(:restaurant_customer,
          restaurant_id: restaurant_id,
          customer_id: customer_id
        )

      Factory.insert(:item, restaurant_customer_id: rc_id)

      response =
        conn
        |> graphql(@total_customers_query, %{restaurant_name: restaurant_name})
        |> json_response(200)
        |> Map.get("data")

      assert response == %{
               "getVisitorsPerRestaurant" => %{
                 "visitors" => 1
               }
             }
    end

    test "if the restaurant has no records in database, returns zero", %{conn: conn} do
      response =
        conn
        |> graphql(@total_customers_query, %{
          restaurant_name: "the-restaurant-at-the-end-of-the-universe"
        })
        |> json_response(200)

      expected_response = %{"data" => %{"getVisitorsPerRestaurant" => %{"visitors" => 0}}}

      assert response == expected_response
    end

    test "when the resolver is dealing with an error, the response is nil", %{conn: conn} do
      %{restaurant_name: restaurant_name, id: restaurant_id} = Factory.insert(:restaurant)

      %{id: customer_id} = Factory.insert(:customer)

      %{id: rc_id} =
        Factory.insert(:restaurant_customer,
          restaurant_id: restaurant_id,
          customer_id: customer_id
        )

      Factory.insert(:item, restaurant_customer_id: rc_id, food_name: "Lasagna")

      response =
        conn
        |> graphql(@total_customers_query, %{error: "something's missing"})
        |> json_response(200)
        |> Map.get("data")

      assert response == nil
    end
  end

  describe "get_most_popular_food_per_restaurant/2" do
    test "returns the most popular dish per restaurant", %{conn: conn} do
      %{restaurant_name: restaurant_name, id: restaurant_id} =
        Factory.insert(:restaurant, restaurant_name: "home-feelings")

      %{id: customer_id} = Factory.insert(:customer)

      %{id: rc_id} =
        Factory.insert(:restaurant_customer,
          restaurant_id: restaurant_id,
          customer_id: customer_id
        )

      Factory.insert(:item, restaurant_customer_id: rc_id, food_name: "Lasagna")

      response =
        conn
        |> graphql(@most_popular_dish_query, %{restaurant_name: restaurant_name})
        |> json_response(200)
        |> Map.get("data")

      assert response == nil
    end

    test "when the resolver is dealing with an error, the response is nil", %{conn: conn} do
      %{restaurant_name: restaurant_name, id: restaurant_id} = Factory.insert(:restaurant)

      %{id: customer_id} = Factory.insert(:customer)

      %{id: rc_id} =
        Factory.insert(:restaurant_customer,
          restaurant_id: restaurant_id,
          customer_id: customer_id
        )

      Factory.insert(:item, restaurant_customer_id: rc_id, food_name: "Lasagna")

      response =
        conn
        |> graphql(@most_popular_dish_query, %{error: "something's missing"})
        |> json_response(200)
        |> Map.get("data")

      assert response == nil
    end
  end

  describe "get_total_profit_per_restaurant/2" do
    test "returns the total profit per restaurant", %{conn: conn} do
      %{restaurant_name: restaurant_name, id: restaurant_id} = Factory.insert(:restaurant)

      %{id: customer_id} = Factory.insert(:customer)

      %{id: rc_id} =
        Factory.insert(:restaurant_customer,
          restaurant_id: restaurant_id,
          customer_id: customer_id
        )

      Factory.insert(:item, restaurant_customer_id: rc_id)

      response =
        conn
        |> graphql(@total_earned_query, %{restaurant_name: restaurant_name})
        |> json_response(200)
        |> Map.get("data")

      assert response == %{
               "getTotalProfitPerRestaurant" => %{
                 "totalProfit" => 18.99
               }
             }
    end

    test "if the restaurant has no records in database, returns zero", %{conn: conn} do
      response =
        conn
        |> graphql(@total_earned_query, %{
          restaurant_name: "the-restaurant-at-the-end-of-the-universe"
        })
        |> json_response(200)

      expected_response = %{"data" => %{"getTotalProfitPerRestaurant" => %{"totalProfit" => 0}}}

      assert response == expected_response
    end

    test "when the resolver is dealing with an error, the response is nil", %{conn: conn} do
      %{restaurant_name: restaurant_name, id: restaurant_id} = Factory.insert(:restaurant)

      %{id: customer_id} = Factory.insert(:customer)

      %{id: rc_id} =
        Factory.insert(:restaurant_customer,
          restaurant_id: restaurant_id,
          customer_id: customer_id
        )

      Factory.insert(:item, restaurant_customer_id: rc_id, food_name: "Lasagna")

      response =
        conn
        |> graphql(@total_earned_query, %{error: "something's missing"})
        |> json_response(200)
        |> Map.get("data")

      assert response == nil
    end
  end

  defp graphql(conn, query, args) do
    get(conn, "/graphql", %{
      "query" => query,
      "variables" => args
    })
  end
end
