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
    |> validate_required([:url])
  end

  def put_short_url(changeset) do
    if get_change(changeset, :short_url) do
      changeset
    else
      changeset
      |> put_change(:short_url, generated_url())
    end
  end

  defp generated_url do
    n = 5

    chars =
      "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" |> String.codepoints()

    black_list = ~w{1 l I 0 O}
    allowed_chars = chars -- black_list

    for(_ <- 1..n, do: allowed_chars |> Enum.random())
    |> Enum.join()
  end
end
