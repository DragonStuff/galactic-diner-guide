defmodule GalacticDinerGuideWeb.Graphql.Middleware.ChangesetErrors do
  @moduledoc """
  Middleware that handles changeset errors and format them to be returned by Absinthe.
  """

  @behaviour Absinthe.Middleware

  @doc """
  Call the middleware.
  """
  def call(resolution, _) do
    %{resolution | errors: Enum.flat_map(resolution.errors, &handle_error/1)}
  end

  defp handle_error(%Ecto.Changeset{} = changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(fn {err, _opts} -> err end)
    |> Enum.map(fn {k, v} -> "#{k}: #{v}" end)
  end

  defp handle_error(error), do: [error]
end
