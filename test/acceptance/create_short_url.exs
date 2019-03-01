defmodule Shortly.CreateShortUrl do
  use Shortly.AcceptanceCase, async: true

  alias Shortly.App

  import Wallaby.Query, only: [css: 2, button: 1]

  test "creat simple url", %{session: session} do
    IO.puts(Application.get_env(:shortly, :base_url))
    test_url = "http://test-url.org"

    session
    |> visit("/")
    |> fill_in(css("#link_url", count: 1), with: test_url)
    |> click(button("Shorten"))
    |> assert_has(css(".origin-link", count: 1, text: test_url))

    link = App.get_link_by_url!(test_url)
    assert link
  end
end
