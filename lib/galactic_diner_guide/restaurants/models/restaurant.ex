defmodule GalacticDinerGuide.Restaurants.Models.Restaurant do
  @moduledoc """
  Database representation of a restaurant.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer

  @required_field ~w(restaurant_name)a
  @optional_fields ~w(is_enabled inserted_at updated_at deleted_at)a
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Jason.Encoder, only: ~w(inserted_at restaurant_name updated_at deleted_at is_enabled)a}

  schema "restaurants" do
    field :restaurant_name, :string
    field :is_enabled, :boolean, default: true
    field :deleted_at, :utc_datetime

    has_many :restaurant_customer, RestaurantCustomer, where: [is_enabled: true]

    timestamps(type: :utc_datetime_usec)
  end

  def build(params) do
    params
    |> changeset()
    # coveralls-ignore-start
    |> apply_action(:insert)

    # coveralls-ignore-stop
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_field ++ @optional_fields)
    |> validate_required(@required_field)
    |> validate_length(:restaurant_name, min: 1, max: 100)
    |> cast_assoc(:restaurant_customer, with: &RestaurantCustomer.changeset/2)
  end
end
