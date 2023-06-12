defmodule GalacticDinerGuide.Repo.Migrations.CreateRestaurantsTable do
  use Ecto.Migration

  def up do
    create table(:restaurants, primary_key: false) do
      add :id, :binary_id, primary_key: true, default: fragment("gen_random_uuid()")
      add :restaurant_name, :string, null: false
      add :deleted_at, :utc_datetime
      add :is_enabled, :boolean, default: true

      timestamps()
    end

    create index(:restaurants, :restaurant_name)
  end

  def down do
    drop index(:restaurants, :restaurant_name)

    drop table(:restaurants)
  end
end
