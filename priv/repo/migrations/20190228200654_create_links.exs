defmodule Shortly.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :url, :string
      add :short_url, :string

      timestamps()
    end

    create unique_index(:links, [:url])
    create unique_index(:links, [:short_url])
  end
end
