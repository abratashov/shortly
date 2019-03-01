defmodule ShortlyWeb.PageController do
  use ShortlyWeb, :controller

  alias Shortly.App
  alias Shortly.App.Link

  import ShortlyWeb.Router.Helpers

  def index(conn, _params) do
    render(conn, "index.html",
      changeset: App.change_link(%Link{}),
      action: link_path(conn, :create),
      links: App.list_links()
    )
  end
end
