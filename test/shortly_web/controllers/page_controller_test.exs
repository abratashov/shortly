defmodule ShortlyWeb.PageControllerTest do
  use ShortlyWeb.ConnCase

  alias Shortly.App
  alias Shortly.App.Link

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Shortly Service!"
  end

  test "GET /:short_url", %{conn: conn} do
    test_url = "http://test.org"
    assert {:ok, %Link{} = link} = App.create_link(%{url: test_url})

    conn = get(conn, "/#{link.short_url}")
    assert redirected_to(conn) == test_url
  end
end
