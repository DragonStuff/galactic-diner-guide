defmodule GalacticDinerGuideWeb.Graphql.Schema do
@moduledoc """
Graphql root schema.
"""


  use Absinthe.Schema

  alias GalacticDinerGuideWeb.Graphql.Middleware.ChangesetErrors

  import_types(Absinthe.Plug.Types)
  import_types(GalacticDinerGuideWeb.Graphql.Schema.Types.Customer)
  import_types(GalacticDinerGuideWeb.Graphql.Schema.Types.Restaurant)

  @desc "The root of query operations"
  query do
    import_fields(:restaurant_queries)
    import_fields(:customer_queries)
  end

  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [ChangesetErrors]
  end

  def middleware(middleware, _field, _object), do: middleware
end
