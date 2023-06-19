defmodule GalacticDinerGuide.RestaurantCustomers.Models.RestaurantCustomer do
  @moduledoc """
  Database representation of an order.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias GalacticDinerGuide.Items.Models.Item

  @required_fields ~w(restaurant_id customer_id)a
  @optional_fields ~w(inserted_at is_enabled updated_at deleted_at)a
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Jason.Encoder,
           only: ~w(inserted_at restaurant_id customer_id updated_at deleted_at is_enabled)a}

  schema "restaurant_customers" do
    field :is_enabled, :boolean, default: true
    field :deleted_at, :utc_datetime
    field :restaurant_id, :binary_id
    field :customer_id, :binary_id

    many_to_many :item, Item, join_through: "restaurant_customer"

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
    |> foreign_key_constraint(:restaurant_id,
      name: "restaurant_customers_restaurant_id_fkey"
    )
    |> foreign_key_constraint(:customer_id,
      name: "restaurant_customers_customer_id_fkey"
    )
    |> cast_assoc(:item, with: &Item.changeset/2)
  end
end
