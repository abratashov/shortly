ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Shortly.Repo, :manual)
{:ok, _} = Application.ensure_all_started(:wallaby)
Application.put_env(:wallaby, :base_url, Application.get_env(:shortly, :base_url))
