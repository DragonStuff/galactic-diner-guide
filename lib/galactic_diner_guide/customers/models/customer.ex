defmodule GalacticDinerGuide.Customers.Models.Customer do
  @moduledoc """
  Database representation of a customer.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(first_name)a
  @optional_fields ~w(is_enabled inserted_at updated_at deleted_at)a
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Jason.Encoder, only: ~w(inserted_at first_name updated_at deleted_at is_enabled)a}

  schema "customers" do
    field :first_name, :string
    field :is_enabled, :boolean, default: true
    field :deleted_at, :utc_datetime

    timestamps(type: :utc_datetime_usec)
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:first_name, min: 1, max: 100)
    |> cast_assoc(:restaurants_customers)
  end
end
