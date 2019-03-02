defmodule Shortly.App.Link do
  use Ecto.Schema
  import Ecto.Changeset

  alias Shortly.App.UrlGenerator

  schema "links" do
    field :short_url, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :short_url])
    |> validate_required([:url])
  end

  def put_short_url(changeset) do
    if get_change(changeset, :short_url) do
      changeset
    else
      changeset
      |> put_change(:short_url, UrlGenerator.uniq_url())
    end
  end
end
