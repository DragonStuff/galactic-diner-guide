defmodule GalacticDinerGuide.Customers.Actions.Delete do
  @moduledoc """
  Soft deletes a customer from database.
  """
  alias GalacticDinerGuide.Error
  alias GalacticDinerGuide.Customers.Actions.{Get, Update}
  alias GalacticDinerGuide.Customers.Models.Customer

  @doc """
  Soft deletes a customer with the given id.
  """
  @spec call(binary()) :: {:ok, Customer.t()} | {:error, Error.t()}
  def call(id) do
    attrs = %{
      deleted_at: DateTime.utc_now(),
      is_enabled: false
    }

    case Get.call(id) do
      # coveralls-ignore-start
      nil ->
        # coveralls-ignore-stop
        {:error, Error.build_customer_not_found_error()}

      _ ->
        Update.call(id, attrs)
    end
  end
end
