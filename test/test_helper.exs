ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(TenExTakeHome.Repo, :manual)
Mox.defmock(TenExTakeHome.MockMarvelApi, for: TenExTakeHome.Api.MarvelBehaviour)
Application.put_env(:ten_ex_take_home, :marvel_api_mock, TenExTakeHome.MockMarvelApi)