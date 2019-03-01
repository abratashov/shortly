defmodule Shortly.AcceptanceCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL

      alias Shortly.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import ShortlyWeb.Router.Helpers
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Shortly.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Shortly.Repo, {:shared, self()})
    end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(Shortly.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end
end
