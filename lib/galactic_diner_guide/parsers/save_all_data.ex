defmodule GalacticDinerGuide.Parsers.SaveAllData do
  @moduledoc """
  This module is responsible for saving the content in the database.
  """
  alias GalacticDinerGuide.{Error, Repo}

  alias GalacticDinerGuide.Customers.Models.Customer
  alias GalacticDinerGuide.Items.Models.Item
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer
  alias GalacticDinerGuide.Restaurants.Models.Restaurant

  alias GalacticDinerGuide.Parsers.BuildFromCsv

  @records_per_chunk 7_000

  @doc """
  Saves the data in the database, rolls back if something goes wrong.
  """
  @spec call(String.t()) :: {:ok, String.t()} | {:error, Error.t()}
  def call(filename) do
    with [food_names, food_costs, first_names, restaurant_names] <- BuildFromCsv.call(filename),
         {:ok, %{restaurant_params: restaurant_data, save_restaurants: _saved_restaurants}} <-
           insert_restaurants(restaurant_names),
         {:ok, %{customer_params: customer_data, save_customers: _saved_customers}} <-
           insert_customers(first_names),
         {:ok,
          %{
            save_restaurant_customers: _restaurant_customer_data = order_data
          }} <- insert_restaurant_customers(restaurant_data, customer_data),
         {:ok,
          %{
            save_items: _saved_items
          }} <- insert_items(food_names, food_costs, order_data) do
      {:ok, "All Data successfully inserted in database"}
    else
      # coveralls-ignore-start
      _ ->
        {:error, "Something went wrong, please restart the process"}
        # coveralls-ignore-stop
    end
  end

  defp insert_restaurants(restaurant_names) do
    Ecto.Multi.new()
    |> Ecto.Multi.run(:restaurant_params, fn _, _ ->
      restaurant_data = restaurant_params(restaurant_names)
      {:ok, restaurant_data}
    end)
    |> Ecto.Multi.run(:save_restaurants, fn _, %{restaurant_params: restaurant_data} ->
      save_restaurants(restaurant_data)
      {:ok, "Restaurants successfully inserted in database"}
    end)
    |> Repo.transaction()
  end

  defp insert_customers(first_names) do
    Ecto.Multi.new()
    |> Ecto.Multi.run(:customer_params, fn _, _ ->
      customer_data = customer_params(first_names)
      {:ok, customer_data}
    end)
    |> Ecto.Multi.run(:save_customers, fn _, %{customer_params: customer_data} ->
      save_customers(customer_data)
      {:ok, "Customers successfully inserted in database"}
    end)
    |> Repo.transaction()
  end

  defp insert_restaurant_customers(restaurant_data, customer_data) do
    {:ok, %{restaurant_customer_params: restaurant_customer_data}} =
      Ecto.Multi.new()
      |> Ecto.Multi.run(:restaurant_customer_params, fn _, _ ->
        restaurant_customer_data = restaurant_customer_params(restaurant_data, customer_data)
        {:ok, restaurant_customer_data}
      end)
      |> Repo.transaction()

    save_related_ids(restaurant_customer_data)
  end

  defp insert_items(food_names, food_costs, restaurant_customer_data) do
    {:ok, %{item_params: item_data}} =
      Ecto.Multi.new()
      |> Ecto.Multi.run(:item_params, fn _, _ ->
        item_data = item_params(food_names, food_costs, restaurant_customer_data)
        {:ok, item_data}
      end)
      |> Repo.transaction()

    save_foods(item_data)
  end

  defp save(data, struct) do
    data
    |> Enum.chunk_every(@records_per_chunk)
    |> Enum.each(fn chunk ->
      Ecto.Multi.new()
      |> Ecto.Multi.run(:insert_all, fn _, _ ->
        Repo.insert_all(struct, chunk)
        {:ok, chunk}
      end)
      |> Ecto.Multi.run(:commit, fn _, _ ->
        {:ok, :committed}
      end)
      |> Repo.transaction()
    end)
  end

  defp save_restaurants(restaurant_data) do
    save(restaurant_data, Restaurant)
  end

  defp save_customers(customer_data) do
    save(customer_data, Customer)
  end

  defp save_restaurant_customers(restaurant_customer_data) do
    save(restaurant_customer_data, RestaurantCustomer)
  end

  defp save_items(item_data) do
    save(item_data, Item)
  end

  defp save_related_ids(restaurant_customer_data) do
    Ecto.Multi.new()
    |> Ecto.Multi.run(:save_restaurant_customers, fn _, _ ->
      save_restaurant_customers(restaurant_customer_data)
      {:ok, restaurant_customer_data}
    end)
    |> Repo.transaction()
  end

  defp save_foods(item_data) do
    Ecto.Multi.new()
    |> Ecto.Multi.run(:save_items, fn _, _ ->
      save_items(item_data)
      {:ok, "Items successfully inserted in database"}
    end)
    |> Repo.transaction()
  end

  defp restaurant_params(restaurant_names) do
    Enum.map(restaurant_names, fn restaurant_name ->
      %{
        id: uuid(),
        restaurant_name: restaurant_name,
        is_enabled: true,
        inserted_at: now(),
        updated_at: now()
      }
    end)
  end

  defp customer_params(first_names) do
    Enum.map(first_names, fn first_name ->
      %{
        id: uuid(),
        first_name: first_name,
        is_enabled: true,
        inserted_at: now(),
        updated_at: now()
      }
    end)
  end

  defp item_params(food_names, food_costs, restaurant_customer_data) do
    restaurant_customer_ids = extract_ids(restaurant_customer_data)

    item_map =
      Enum.map(restaurant_customer_ids, fn restaurant_customer_id ->
        %{
          id: uuid(),
          restaurant_customer_id: restaurant_customer_id,
          is_enabled: true,
          inserted_at: now(),
          updated_at: now()
        }
      end)

    map_with_food_name =
      Enum.zip(item_map, food_names)
      |> Enum.map(fn {map, food_name} ->
        Map.put(map, :food_name, food_name)
      end)

    Enum.zip(map_with_food_name, food_costs)
    |> Enum.map(fn {map, food_cost} ->
      Map.put(map, :food_cost, String.to_float(food_cost))
    end)
  end

  defp restaurant_customer_params(restaurant_data, customer_data) do
    restaurant_ids = extract_ids(restaurant_data)
    customer_ids = extract_ids(customer_data)

    order_map =
      Enum.map(restaurant_ids, fn restaurant_id ->
        %{
          id: uuid(),
          restaurant_id: restaurant_id,
          is_enabled: true,
          inserted_at: now(),
          updated_at: now()
        }
      end)

    Enum.zip(order_map, customer_ids)
    |> Enum.map(fn {map, customer_id} ->
      Map.put(map, :customer_id, customer_id)
    end)
  end

  defp extract_ids(data) do
    Enum.map(data, & &1.id)
  end

  defp now, do: DateTime.utc_now()
  defp uuid, do: UUID.uuid4()
end
