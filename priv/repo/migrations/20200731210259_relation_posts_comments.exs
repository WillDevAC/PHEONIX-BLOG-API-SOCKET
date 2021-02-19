defmodule Blog.Repo.Migrations.RelationPostsComments do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :post_id, references(:posts, on_delete: :delete_all)
    end
  end
end
