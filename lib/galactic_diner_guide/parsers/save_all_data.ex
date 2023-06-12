defmodule GalacticDinerGuide.Parsers.SaveAllData do
  @moduledoc """
  This module is responsible for saving the content in database.
  """
  alias GalacticDinerGuide.{Error, Repo}

  alias GalacticDinerGuide.Customers.Models.Customer
  alias GalacticDinerGuide.Items.Models.Item
  alias GalacticDinerGuide.Restaurants.Models.Restaurant
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer

  alias GalacticDinerGuide.Parsers.BuildFromCsv

  require Logger

  @records_per_chunk 10_000
  @timeout 180_000
  @total_orders 1..150_001

  @doc """
  Saves the data in the database.
  """
  @spec call(String.t()) :: {:ok, String.t()} | {:error, Error.t()}
  def call(filename) do
    [food_names, food_costs, first_names, restaurant_names] = BuildFromCsv.call(filename)

    tasks = [
      Task.await(Task.async(fn -> save_restaurants(restaurant_names) end), :infinity),
      Task.await(Task.async(fn -> save_customers(first_names) end), :infinity),
      Task.await(Task.async(fn -> save_restaurant_customers() end), :infinity),
      Task.await(Task.async(fn -> save_items(food_names, food_costs) end), :infinity)
    ]

    Task.await_many(tasks, @timeout)
  end

  defp save_restaurants(restaurant_names) do
    restaurant_data =
      Enum.map(restaurant_names, fn restaurant_name ->
        %{
          id: uuid(),
          restaurant_name: restaurant_name,
          is_enabled: true,
          inserted_at: now(),
          updated_at: now()
        }
      end)

    restaurant_data
    |> Stream.chunk_every(@records_per_chunk)
    |> Task.async_stream(
      fn chunk ->
        Repo.insert_all(Restaurant, chunk)
      end,
      max_concurrency: 1
    )
    |> Stream.run()

    :ok
  end

  defp save_customers(first_names) do
    customer_data =
      Enum.map(first_names, fn first_name ->
        %{
          id: uuid(),
          first_name: first_name,
          is_enabled: true,
          inserted_at: now(),
          updated_at: now()
        }
      end)

    customer_data
    |> Stream.chunk_every(@records_per_chunk)
    |> Task.async_stream(
      fn chunk ->
        Repo.insert_all(Customer, chunk)
      end,
      max_concurrency: 1
    )
    |> Stream.run()

    :ok
  end

  defp save_restaurant_customers do
    customer_ids = Repo.all(Customer) |> Enum.map(& &1.id)
    restaurant_ids = Repo.all(Restaurant) |> Enum.map(& &1.id)
  
    data =
      Enum.zip(restaurant_ids, customer_ids)
      |> Enum.with_index()
      |> Enum.map(fn {{restaurant_id, customer_id}, index} ->
        %{
          id: uuid(),
          restaurant_id: Enum.at(restaurant_ids, rem(index, length(restaurant_ids))),
          customer_id: customer_id,
          is_enabled: true,
          inserted_at: now(),
          updated_at: now()
        }
      end)
  
    data
    |> Stream.chunk_every(@records_per_chunk)
    |> Task.async_stream(
      fn chunk ->
        Repo.insert_all(RestaurantCustomer, chunk)
      end,
      max_concurrency: 1
    )
    |> Stream.run()
  
    :ok
  end
  
  def save_items(food_names, food_costs) do
    remaining_ids = Repo.all(RestaurantCustomer) |> Enum.map(& &1.id)

    item_data =
      Enum.with_index(food_names)
      |> Enum.map(fn {food_name, index} ->
        id = Enum.at(remaining_ids, rem(index, length(remaining_ids)))

        %{
          id: uuid(),
          restaurant_customer_id: id,
          food_name: food_name,
          food_cost: String.to_float(Enum.at(food_costs, index)),
          inserted_at: now(),
          updated_at: now()
        }
      end)

    item_data
    |> Stream.chunk_every(@records_per_chunk)
    |> Task.async_stream(
      fn chunk ->
        Repo.insert_all(Item, chunk)
      end,
      max_concurrency: 1
    )
    |> Stream.run()

    :ok
  end

  defp now, do: DateTime.utc_now()
  defp uuid, do: UUID.uuid4()
end
