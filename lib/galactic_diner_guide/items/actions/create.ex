defmodule GalacticDinerGuide.Items.Actions.Create do
  @moduledoc """
  Creates a new item.
  """
  alias GalacticDinerGuide.{Error, Repo}
  alias GalacticDinerGuide.Items.Models.Item

  @doc """
  Creates a new item with the given params.
  """
  @spec call(map) :: {:ok, Item.t()} | {:error, Error.t()}
  def call(params) do
    params
    |> Item.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Item{} = result}), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
