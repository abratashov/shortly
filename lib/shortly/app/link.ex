defmodule Shortly.App.Link do
  use Ecto.Schema
  import Ecto.Changeset

  alias Shortly.App.UrlGenerator

  @base_host Application.get_env(:shortly, :base_host)

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
    |> validate_url()
    |> validate_self_reffering()
  end

  def put_short_url(changeset) do
    if get_change(changeset, :short_url) do
      changeset
    else
      changeset
      |> put_change(:short_url, UrlGenerator.uniq_url())
    end
  end

  defp validate_url(changeset) do
    validate_change(changeset, :url, fn _, url ->
      case URI.parse(url) do
        %URI{scheme: nil} -> [{:url, "URL doesn't contain scheme"}]
        %URI{host: nil} -> [{:url, "URL doesn't contain host"}]
        _ -> []
      end
    end)
  end

  defp validate_self_reffering(changeset) do
    validate_change(changeset, :url, fn _, url ->
      case Regex.match?(~r/#{@base_host}/, url) do
        true -> [{:url, "URL can't referer to this domain"}]
        false -> []
      end
    end)
  end
end
