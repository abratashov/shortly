defmodule ShortlyWeb.LinkController do
  use ShortlyWeb, :controller

  alias Shortly.App
  alias Shortly.App.Link

  import ShortlyWeb.Router.Helpers

  @base_url Application.get_env(:shortly, :base_url)

  @env Mix.env()
  plug BasicAuth,
       [use_config: {:shortly, :http_auth_config}]
       when not (action in [:create]) and @env not in [:test]

  def index(conn, _params) do
    links = App.list_links()
    render(conn, "index.html", links: links)
  end

  def new(conn, _params) do
    changeset = App.change_link(%Link{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"link" => link_params}) do
    case App.create_link(link_params) do
      {:ok, link} ->
        conn
        |> put_flash(:info, "Link created successfully.")
        |> redirect(to: redirection_path(conn, link))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    link = App.get_link!(id)
    render(conn, "show.html", link: link)
  end

  def edit(conn, %{"id" => id}) do
    link = App.get_link!(id)
    changeset = App.change_link(link)
    render(conn, "edit.html", link: link, changeset: changeset)
  end

  def update(conn, %{"id" => id, "link" => link_params}) do
    link = App.get_link!(id)

    case App.update_link(link, link_params) do
      {:ok, link} ->
        conn
        |> put_flash(:info, "Link updated successfully.")
        |> redirect(to: link_path(conn, :show, link))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", link: link, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    link = App.get_link!(id)
    {:ok, _link} = App.delete_link(link)

    conn
    |> put_flash(:info, "Link deleted successfully.")
    |> redirect(to: link_path(conn, :index))
  end

  defp redirection_path(conn, link) do
    if main_page_referer?(conn) do
      page_path(conn, :index, created_link: link)
    else
      link_path(conn, :show, link)
    end
  end

  defp main_page_referer?(conn) do
    referer = get_req_header(conn, "referer") |> Enum.at(0)

    referer == "#{@base_url}/" ||
      Regex.match?(~r/#{@base_url}\/\?created_link=/, referer)
  end
end
