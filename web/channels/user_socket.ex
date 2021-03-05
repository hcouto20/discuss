defmodule Discuss.UserSocket do
  use Phoenix.Socket

  channel("comments:*", Discuss.CommentsChannel)
  # no controlador -> get("/comments/:id", CommentController, :join, :handle_in)

  transport(:websocket, Phoenix.Transports.WebSocket)

  def connect(_params, socket) do

  end

  def id(_socket), do: nil
end
