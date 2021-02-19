defmodule Blog.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:content, :user]}
  schema "comments" do
    field :content, :string

    belongs_to :post, Blog.Posts.Post
    belongs_to :user, Blog.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
