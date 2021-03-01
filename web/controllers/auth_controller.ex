defmodule Discuss.AuthController do
  use Discuss.Web, :controller

  plug(Ueberauth)

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    user_params = %{
      token: auth.credentials.token,
      email: auth.info.email,
      provider: auth.state.provider
    }

    IO.inspect(user_params)
  end
end
