defmodule TenExTakeHome.Schema.ApiCallTimestamps do
  use Ecto.Schema
  import Ecto.Changeset

  schema "api_call_timestamps" do
    field :timestamp, :utc_datetime
    field :query_offset, :integer
    field :page_limit, :integer

    timestamps()
  end

  @doc false
  def changeset(api_call_timestamps, attrs) do
    api_call_timestamps
    |> cast(attrs, [:timestamp])
    |> validate_required([:timestamp])
  end
end
