defmodule GalacticDinerGuide.Repo.Migrations.CreateRestaurantCustomersTable do
  use Ecto.Migration

  def up do
    create table(:restaurant_customers, primary_key: false) do
      add :id, :binary_id, primary_key: true, default: fragment("gen_random_uuid()")
      add :deleted_at, :utc_datetime
      add :is_enabled, :boolean, default: true
      add :restaurant_id, :binary_id
      add :customer_id, :binary_id

      # add :restaurant_id, references(:restaurants, type: :binary_id), null: false
      # add :customer_id, references(:customers, type: :binary_id), null: false

      timestamps()
    end

    create index(:restaurant_customers, :id)
  end

  def down do
    drop index(:restaurant_customers, :id)

    drop table(:restaurant_customers)
  end
end
