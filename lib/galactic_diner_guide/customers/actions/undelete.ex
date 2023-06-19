defmodule GalacticDinerGuide.Customers.Actions.Undelete do
  @moduledoc """
  Soft undeletes an customer from database.
  """
  alias GalacticDinerGuide.Error
  alias GalacticDinerGuide.Customers.Actions.{Get, Update}
  alias GalacticDinerGuide.Customers.Models.Customer

  @doc """
  Soft undeletes a customer with the given id.
  """
  @spec call(binary()) :: {:ok, Customer.t()} | {:error, Error.t()}
  def call(id) do
    attrs = %{
      deleted_at: nil,
      is_enabled: true
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
