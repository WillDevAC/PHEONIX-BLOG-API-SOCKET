defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :description, :string

    belongs_to :user, Blog.Accounts.User
    has_many :comments, Blog.Comments.Comment
    timestamps()
  end

  def changeset(post, attrs \\ %{}) do
    post
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description], message: "campo obrigatorio")
  end
end
