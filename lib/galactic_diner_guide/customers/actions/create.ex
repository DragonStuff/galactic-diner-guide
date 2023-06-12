defmodule GalacticDinerGuide.Customers.Actions.Create do
  @moduledoc """
  Creates a new customer.
  """
  alias GalacticDinerGuide.{Error, Repo}
  alias GalacticDinerGuide.Customers.Models.Customer

  @doc """
  Creates a new customer with the given params.
  """
  @spec call(map) :: {:ok, Customer.t()} | {:error, Error.t()}
  def call(params) do
    params
    |> Customer.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Customer{} = result}), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
