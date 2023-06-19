defmodule GalacticDinerGuideWeb.Graphql.Schema.Types.Customer do
  @moduledoc """
  Graphql schema which deals with :restaurants table.
  """
  use Absinthe.Schema.Notation

  alias Crudry.Middlewares.TranslateErrors
  alias GalacticDinerGuideWeb.Graphql.Resolvers.Customer, as: CustomerResolver

  object :customer do
    field :key, :string
    field :most_frequent_visitors, :string
  end

  object :customer_queries do
    @desc "Get most frequent visitors"
    field :get_most_frequent_visitors, :customer do
      arg(:key, :string)
      resolve &CustomerResolver.get_most_frequent_visitor/2
      middleware TranslateErrors
    end
  end
end
