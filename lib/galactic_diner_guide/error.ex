defmodule GalacticDinerGuide.Error do
  @moduledoc """
  Error struct
  """

  @keys [:status, :result]

  @enforce_keys @keys

  defstruct @keys

  def build(status, result) do
    %__MODULE__{
      status: status,
      result: result
    }
  end

  def build_bad_request_error, do: build(:bad_request, "Bad request")
  def build_item_not_found_error, do: build(:not_found, "Item not found")
  def build_customer_not_found_error, do: build(:not_found, "Customer not found")
  def build_record_already_deleted_error, do: build(:bad_request, "Record already deleted")
  def build_order_not_found_error, do: build(:not_found, "RestaurantCustomers not found")
  def build_restaurant_not_found_error, do: build(:not_found, "Restaurant not found")
end
