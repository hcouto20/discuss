defmodule Discuss.UserSocket do
  use Phoenix.Socket

  channel("comments:*", Discuss.CommentsChannel)

  transport(:websocket, Phoenix.Transports.WebSocket)

  # Adiciona o ID do usúario ao socket através do token, porém verifica se esse usuário existe ou não
  def connect(%{"token" => token}, socket) do
    # IO.puts(token)

    case Phoenix.Token.verify(socket, "key", token) do
      {:ok, user_id} ->
        {:ok, assign(socket, :user_id, user_id)}

      {:error, _error} ->
        :error
    end
  end

  def id(_socket), do: nil
end
