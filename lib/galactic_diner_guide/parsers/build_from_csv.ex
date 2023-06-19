defmodule GalacticDinerGuide.Parsers.BuildFromCsv do
  @moduledoc """
  Parses the data from the csv file.
  """

  @doc """
  Streams and parses the csv content.
  """
  @spec call(String.t()) :: [list()]
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
