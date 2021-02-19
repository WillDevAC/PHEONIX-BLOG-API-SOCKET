defmodule Blog.CommentsTest do
  use Blog.DataCase

  alias Blog.Comments

  describe "comments" do
    alias Blog.Comments.Comment

    @valid_attrs %{content: "some content"}
    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    def comment_fixture(attrs \\ %{}) do
      post = Blog.PostsTest.post_fixture()
      user = Blog.Accounts.get_user!(1)

      att =
        attrs
        |> Enum.into(@valid_attrs)

      {:ok, comment} =
        post.id
        |> Comments.create_comment(user.id, att)

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Comments.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Comments.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      post = Blog.PostsTest.post_fixture()
      user = Blog.Accounts.get_user!(1)
      assert {:ok, %Comment{} = comment} = Comments.create_comment(post.id, user.id, @valid_attrs)
      assert comment.content == "some content"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      post = Blog.PostsTest.post_fixture()
      assert {:error, %Ecto.Changeset{}} = Comments.create_comment(post.id, @invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{} = comment} = Comments.update_comment(comment, @update_attrs)
      assert comment.content == "some updated content"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Comments.update_comment(comment, @invalid_attrs)
      assert comment == Comments.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Comments.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Comments.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Comments.change_comment(comment)
    end
  end
end
