defmodule GalacticDinerGuide.Parsers.BuildFromCsv do
  @moduledoc """
  This module is responsible for parsing the data from the csv file.
  """
  alias GalacticDinerGuide.Repo

  alias GalacticDinerGuide.Customers.Models.Customer
  alias GalacticDinerGuide.Items.Models.Item
  alias GalacticDinerGuide.Restaurants.Models.Restaurant
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer

  @doc """
  This function streams and parses the csv content.
  """
  def call(filename) do
    "sources/#{filename}"
    |> File.stream!()
    |> Stream.drop(1)
    |> Stream.map(&String.trim(&1))
    |> Stream.map(&String.split(&1, ","))
    |> Enum.reduce(
      %{restaurant_names: [], first_names: [], food_names: [], food_costs: []},
      fn [restaurant_name, first_name, food_name, food_cost], acc ->
        %{
          acc
          | restaurant_names: [restaurant_name | acc.restaurant_names],
            first_names: [first_name | acc.first_names],
            food_names: [food_name | acc.food_names],
            food_costs: [food_cost | acc.food_costs]
        }
      end
    )
    |> Map.values()
    |> Enum.map(&Enum.reverse/1)
  end
end
