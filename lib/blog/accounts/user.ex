defmodule Blog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:email, :image]}
  schema "users" do
    field :email, :string
    field :first_name, :string
    field :image, :string
    field :last_name, :string
    field :provider, :string
    field :token, :string

    has_many :posts, Blog.Posts.Post
    has_many :comments, Blog.Comments.Comment
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :image, :provider, :email, :token])
    |> validate_required([:provider, :email, :token])
  end
end
