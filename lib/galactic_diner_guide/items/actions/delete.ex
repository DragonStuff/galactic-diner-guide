defmodule GalacticDinerGuide.Items.Actions.Delete do
  @moduledoc """
  Soft deletes an item from database.
  """
  alias GalacticDinerGuide.Error
  alias GalacticDinerGuide.Items.Actions.{Get, Update}
  alias GalacticDinerGuide.Items.Models.Item

  @doc """
  Soft deletes an item with the given id.
  """
  @spec call(binary()) :: {:ok, Item.t()} | {:error, Error.t()}
  def call(id) do
    attrs = %{
      deleted_at: DateTime.utc_now(),
      is_enabled: false
    }

    case Get.call(id) do
      # coveralls-ignore-start
      nil ->
        # coveralls-ignore-stop
        {:error, Error.build_item_not_found_error()}

      _ ->
        Update.call(id, attrs)
    end
  end
end
