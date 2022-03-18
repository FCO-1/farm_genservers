defmodule FarmGenservers.Repo do
  use Ecto.Repo,
    otp_app: :farm_genservers,
    adapter: Ecto.Adapters.Postgres
end
