defmodule GalacticDinerGuide.Items.Actions.Get do
  @moduledoc """
  Gets an item from database.
  """
  alias GalacticDinerGuide.{Error, Repo}
  alias GalacticDinerGuide.Items.Models.Item

  @doc """
  Gets an item from database with the given id.
  """
  @spec call(binary()) :: {:ok, Item.t()} | {:error, Error.t()}
  def call(id) do
    case Repo.get(Item, id) do
      nil -> {:error, Error.build_item_not_found_error()}
      item -> {:ok, item}
    end
  end
end
