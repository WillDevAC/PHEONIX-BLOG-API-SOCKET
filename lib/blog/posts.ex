defmodule Blog.Posts do
  alias Blog.{Posts.Post, Repo}
  import Ecto.Query, warn: false

  def list_posts(user_id \\ nil) do
    if user_id do
      query = from p in Post, where: p.user_id == ^user_id
      Repo.all(query)
    else
      Repo.all(Post)
    end
  end

  def get_post!(id), do: Repo.get!(Post, id)

  def get_post_with_comments!(id), do: Repo.get!(Post, id) |> Repo.preload(comments: [:user])

  def create_post(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:posts)
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(post, post_params) do
    post
    |> Post.changeset(post_params)
    |> Repo.update()
  end

  def delete(id) do
    get_post!(id)
    |> Repo.delete!()
  end
end
