defmodule GalacticDinerGuide.Items.Actions.Undelete do
  @moduledoc """
  Soft undeletes an item from database.
  """
  alias GalacticDinerGuide.Error
  alias GalacticDinerGuide.Items.Actions.{Get, Update}
  alias GalacticDinerGuide.Items.Models.Item

  @doc """
  Soft undeletes an item with the given id.
  """
  @spec call(binary()) :: {:ok, Item.t()} | {:error, Error.t()}
  def call(id) do
    attrs = %{
      deleted_at: nil,
      is_enabled: true
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
