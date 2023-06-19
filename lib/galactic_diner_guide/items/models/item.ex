defmodule GalacticDinerGuide.Items.Models.Item do
  @moduledoc """
  Database representation of an item.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer

  @required_fields ~w(food_name food_cost restaurant_customer_id)a
  @optional_fields ~w(is_enabled inserted_at updated_at deleted_at)a
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Jason.Encoder,
           only:
             ~w(inserted_at food_name food_cost restaurant_customer_id updated_at deleted_at is_enabled)a}

  schema "items" do
    field :food_name, :string
    field :food_cost, :float
    field :is_enabled, :boolean, default: true
    field :deleted_at, :utc_datetime
    field :restaurant_customer_id, :binary_id

    many_to_many :restaurant_customer, RestaurantCustomer, join_through: "restaurant_customer"

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
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:food_name, min: 1, max: 100)
    |> validate_number(:food_cost, greater_than_or_equal_to: 0)
    |> foreign_key_constraint(:restaurant_customer_id,
      name: "items_restaurant_customers_id_fkey"
    )
  end
end
