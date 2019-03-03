defmodule Shortly.UrlGeneratorTest do
  use Shortly.DataCase

  alias Shortly.App

  describe "urls" do
    alias Shortly.App.Link
    alias Shortly.App.UrlGenerator

    test "generate correct short URL" do
      assert UrlGenerator.uniq_url() |> String.length() == 5
    end
  end
end
