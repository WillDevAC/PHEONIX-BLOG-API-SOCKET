defmodule BlogWeb.PageController do
  use BlogWeb, :controller
  alias Blog.Posts

  def index(conn, _params) do
    render(conn, "index.html", posts: Posts.list_posts())
  end
end
