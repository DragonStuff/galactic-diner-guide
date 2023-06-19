defmodule GalacticDinerGuide.Repo.Migrations.CreateItemsTable do
  use Ecto.Migration

  def up do
    create table(:items, primary_key: false) do
      add :id, :binary_id, primary_key: true, default: fragment("gen_random_uuid()")
      add :food_name, :string
      add :food_cost, :float
      add :deleted_at, :utc_datetime
      add :is_enabled, :boolean, default: true
      add :restaurant_customer_id, :binary_id

      timestamps()
    end

    create constraint(:items, :food_cost_must_be_greater_than_0, check: "food_cost > 0")

    create index(:items, [:food_cost, :food_name])
    create index(:items, :restaurant_customer_id)
  end

  def down do
    drop index(:items, [:food_cost, :food_name])
    drop index(:items, :restaurant_customer_id)

    drop table(:items)
  end
end
