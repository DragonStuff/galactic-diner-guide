defmodule GalacticDinerGuide.Customers.Actions.Update do
  @moduledoc """
  Updates an customer from database.
  """
  alias GalacticDinerGuide.{Error, Repo}
  alias GalacticDinerGuide.Customers.Models.Customer

  @doc """
  Updates a customer from database with the given attributes.
  """
  @spec call(binary(), map()) :: {:ok, Customer.t()} | {:error, Error.t()}
  def call(id, attrs) do
    case Repo.get(Customer, id) do
      nil -> {:error, Error.build_customer_not_found_error()}
      customer -> do_update(customer, attrs)
    end
  end

  defp do_update(customer, attrs) do
    customer
    |> Customer.changeset(attrs)
    |> Repo.update()
  end
end
