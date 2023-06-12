defmodule GalacticDinerGuide.Customers.Actions.Get do
  @moduledoc """
  Gets an customer from database.
  """
  alias GalacticDinerGuide.{Error, Repo}
  alias GalacticDinerGuide.Customers.Models.Customer

  @doc """
  Gets a customer from database with the given id.
  """
  @spec call(binary()) :: {:ok, Customer.t()} | {:error, Error.t()}
  def call(id) do
    case Repo.get(Customer, id) do
      nil -> {:error, Error.build_customer_not_found_error()}
      customer -> {:ok, customer}
    end
  end
end
