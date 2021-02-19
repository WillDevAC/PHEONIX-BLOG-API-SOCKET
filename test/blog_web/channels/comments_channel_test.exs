defmodule BlogWeb.CommentsChannelTest do
  use BlogWeb.ChannelCase
  alias BlogWeb.UserSocket

  @valid_post %{
    title: "Phoenix Framework",
    description: "Lorem"
  }

  setup do
    user = Blog.Accounts.get_user!(1)

    token = Phoenix.Token.sign(BlogWeb.Endpoint, "blog_user", user.id)
    {:ok, post} = Blog.Posts.create_post(user, @valid_post)
    {:ok, socket} = connect(UserSocket, %{"token" => token})

    {:ok, socket: socket, post: post}
  end

  test "deve se conectar ao socket", %{socket: socket, post: post} do
    {:ok, comentarios, socket} = subscribe_and_join(socket, "comments:#{post.id}", %{})
    assert post.id == socket.assigns.post_id
    assert [] == comentarios.comments
  end

  test "deve criar um comentario", %{socket: socket, post: post} do
    {:ok, _comentarios, socket} = subscribe_and_join(socket, "comments:#{post.id}", %{})

    ref = push(socket, "comment:add", %{"content" => "abcd"})

    msg = %{comment: %{content: "abcd"}}
    assert_reply ref, :ok, %{}
    broadcast_event = "comments:#{post.id}:new"
    assert_broadcast broadcast_event, msg
    refute is_nil(msg)
  end
end
