defmodule GalacticDinerGuide.Restaurants.Actions.Create do
  @moduledoc """
  Creates a new restaurant.
  """
  alias GalacticDinerGuide.{Error, Repo}
  alias GalacticDinerGuide.Restaurants.Models.Restaurant

  @doc """
  Creates a new restaurant with the given params.
  """
  @spec call(map) :: {:ok, Restaurant.t()} | {:error, Error.t()}
  def call(params) do
    params
    |> Restaurant.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Restaurant{} = result}), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
