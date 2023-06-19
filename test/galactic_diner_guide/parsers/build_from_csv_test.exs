defmodule GalacticDinerGuide.Parsers.BuildFromCsvTest do
  use ExUnit.Case

  alias GalacticDinerGuide.Parsers.BuildFromCsv

  describe "call/1" do
    test "parses the csv file content and slices it into four lists" do
      assert [food_names, food_costs, first_names, restaurant_names] =
               BuildFromCsv.call("data.csv")

      assert "the-restaurant-at-the-end-of-the-universe" in restaurant_names
      assert "coffee" in food_names
      assert "Alexandra" in first_names
      assert "4.5" in food_costs
    end
  end
end
