defmodule Shortly.App.Link do
  use Ecto.Schema
  import Ecto.Changeset


  schema "links" do
    field :short_url, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :short_url])
    |> validate_required([:url, :short_url])
  end
end
