defmodule TenExTakeHome.Schema.ApiCallTimestamps do
  use Ecto.Schema
  import Ecto.Changeset
  alias TenExTakeHome.Repo
  alias TenExTakeHome.Schema.ApiCallTimestamps

  schema "api_call_timestamps" do
    field :timestamp, :utc_datetime
    field :query_offset, :integer
    field :page_limit, :integer
    field :error_reason, :string

    timestamps()
  end

  @doc false
  def changeset(api_call_timestamps, attrs) do
    api_call_timestamps
    |> cast(attrs, [:timestamp, :query_offset, :page_limit, :error_reason])
    |> validate_required([:timestamp])
  end

  def create_timestamp(attrs) do
    # %ApiCallTimestamps{}
    # |> changeset(attrs)
    # |> Repo.insert!
  end
end
