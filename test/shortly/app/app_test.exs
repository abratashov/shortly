defmodule Shortly.AppTest do
  use Shortly.DataCase

  alias Shortly.App

  describe "links" do
    alias Shortly.App.Link

    @valid_attrs %{short_url: "some short_url", url: "some url"}
    @update_attrs %{short_url: "some updated short_url", url: "some updated url"}
    @invalid_attrs %{short_url: nil, url: nil}

    def link_fixture(attrs \\ %{}) do
      {:ok, link} =
        attrs
        |> Enum.into(@valid_attrs)
        |> App.create_link()

      link
    end

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert App.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert App.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      assert {:ok, %Link{} = link} = App.create_link(@valid_attrs)
      assert link.short_url == "some short_url"
      assert link.url == "some url"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = App.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      assert {:ok, %Link{} = link} = App.update_link(link, @update_attrs)
      assert link.short_url == "some updated short_url"
      assert link.url == "some updated url"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = App.update_link(link, @invalid_attrs)
      assert link == App.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = App.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> App.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = App.change_link(link)
    end
  end
end
