defmodule ShortlyWeb.PageView do
  use ShortlyWeb, :view

  @base_url Application.get_env(:shortly, :base_url)

  def full_short_url(url) do
    "#{@base_url}/#{url}"
  end
end
