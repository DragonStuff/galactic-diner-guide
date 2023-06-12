defmodule GalacticDinerGuide.RestaurantCustomers.Actions.Create do
  @moduledoc """
  Creates a new RestaurantCustomer (order).
  """
  alias GalacticDinerGuide.{Error, Repo}
  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer

  @doc """
  Creates a new RestaurantCustomer with the given params.
  """
  @spec call(map) :: {:ok, RestaurantCustomer.t()} | {:error, Error.t()}
  def call(params) do
    params
    |> RestaurantCustomer.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %RestaurantCustomer{} = result}), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
