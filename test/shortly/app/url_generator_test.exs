defmodule Shortly.UrlGeneratorTest do
  use Shortly.DataCase
  use ExUnit.Case, async: false

  alias Shortly.Repo

  import ExMock

  describe "urls" do
    alias Shortly.App.UrlGenerator

    test "generate correct short URL" do
      assert UrlGenerator.uniq_url() |> String.length() == 5
    end

    test "generate correct short URL with huge amount of records" do
      with_mocks([
        {Repo, [],
         [
           get_by: fn _, _ -> nil end,
           aggregate: fn _, _, _ -> 100_000_000_000_000_000_000_000_000 end
         ]}
      ]) do
        assert UrlGenerator.uniq_url() |> String.length() == 16
      end
    end
  end
end
