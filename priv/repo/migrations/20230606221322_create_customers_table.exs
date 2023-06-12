defmodule GalacticDinerGuide.Repo.Migrations.CreateCustomersTable do
  use Ecto.Migration

  def up do
    create table(:customers, primary_key: false) do
      add :id, :binary_id, primary_key: true, default: fragment("gen_random_uuid()")
      add :first_name, :string
      add :deleted_at, :utc_datetime
      add :is_enabled, :boolean, default: true

      timestamps()
    end

    create index(:customers, :first_name)
  end

  def down do
    drop index(:customers, :first_name)

    drop table(:customers)
  end
end
