defmodule Shortly.App.UrlGenerator do
  alias Shortly.Repo
  alias Shortly.App.Link

  @max_attempts 20
  @chars "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" |> String.codepoints()
  @black_list ~w{1 l I 0 O}
  @start_length 5
  @max_length 20

  def uniq_url(attempt \\ 1) do
    url = random_url
    link = Repo.get_by(Link, short_url: url)
    if link && attempt < @max_attempts, do: uniq_url(attempt + 1), else: url
  end

  def random_url do
    allowed_chars = @chars -- @black_list
    n = calculate_length(allowed_chars)

    for(_ <- 1..n, do: allowed_chars |> Enum.random())
    |> Enum.join()
  end

  defp calculate_length(chars_set) do
    db_count = Repo.aggregate(Link, :count, :id)
    amount = length(chars_set)
    capacity = :math.pow(amount, @start_length - 1)

    min_length(@start_length, amount, capacity, db_count)
  end

  defp min_length(@max_length, _, _, _), do: @max_length
  defp min_length(n, amount, capacity, db_count) when capacity > db_count, do: n

  defp min_length(n, amount, capacity, db_count),
    do: min_length(n + 1, amount, capacity * amount, db_count)
end
