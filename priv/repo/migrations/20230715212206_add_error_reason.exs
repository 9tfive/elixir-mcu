defmodule TenExTakeHome.Repo.Migrations.AddErrorReason do
  use Ecto.Migration

  def change do
    alter table(:api_call_timestamps) do
      add :error_reason, :string
    end
  end
end
