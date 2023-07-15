defmodule TenExTakeHome.Repo.Migrations.CreateApiCallTimestamp do
  use Ecto.Migration

  def change do
    create table(:api_call_timestamps) do
      add :timestamp, :utc_datetime
      add :query_offset, :integer
      add :page_limit, :integer 

      timestamps()
    end
  end
end