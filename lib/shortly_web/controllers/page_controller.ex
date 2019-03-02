defmodule ShortlyWeb.PageController do
  use ShortlyWeb, :controller

  alias Shortly.App
  alias Shortly.App.Link

  import ShortlyWeb.Router.Helpers

  def index(conn, params) do
    render(conn, "index.html",
      changeset: App.change_link(%Link{}),
      action: link_path(conn, :create),
      links: App.last_1000_links(),
      created_link: created_link(params)
    )
  end

  def show(conn, %{"short_url" => short_url}) do
    link = App.get_link_by_short_url!(short_url)

    if link do
      redirect(conn, external: link.url)
    else
      redirect(conn, to: page_path(conn, :index))
    end
  end

  defp created_link(params) do
    if params["created_link"] do
      App.get_link!(params["created_link"])
    end
  end
end
