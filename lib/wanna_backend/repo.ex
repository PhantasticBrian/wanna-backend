defmodule WannaBackend.Repo do
  use Ecto.Repo,
    otp_app: :wanna_backend,
    adapter: Ecto.Adapters.Postgres
end
