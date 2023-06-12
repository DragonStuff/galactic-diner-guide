defmodule GalacticDinerGuide.Items.Actions.Update do
  @moduledoc """
  Updates an item from database.
  """
  alias GalacticDinerGuide.{Error, Repo}
  alias GalacticDinerGuide.Items.Models.Item

  @doc """
  Updates an item from database with the given attributes.
  """
  @spec call(binary(), map()) :: {:ok, Item.t()} | {:error, Error.t()}
  def call(id, attrs) do
    case Repo.get(Item, id) do
      nil -> {:error, Error.build_item_not_found_error()}
      item -> do_update(item, attrs)
    end
  end

  defp do_update(item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end
end
