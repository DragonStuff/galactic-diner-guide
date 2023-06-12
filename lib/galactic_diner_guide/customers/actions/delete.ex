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
      nil ->
        {:error, Error.build_customer_not_found_error()}

      %Customer{is_enabled: false} ->
        {:error, Error.build_record_already_deleted_error()}

      _ ->
        Update.call(id, %{
          is_enabled: false,
          deleted_at: DateTime.utc_now()
        })
    end
  end
end
