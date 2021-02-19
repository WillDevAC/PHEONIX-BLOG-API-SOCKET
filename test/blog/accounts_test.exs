defmodule Blog.AccountsTest do
  use Blog.DataCase

  alias Blog.Accounts

  describe "users" do
    alias Blog.Accounts.User

    @valid_attrs %{
      email: "some email",
      first_name: "some first_name",
      image: "some image",
      last_name: "some last_name",
      provider: "some provider",
      token: "some token"
    }
    @update_attrs %{
      email: "some updated email",
      first_name: "some updated first_name",
      image: "some updated image",
      last_name: "some updated last_name",
      provider: "some updated provider",
      token: "some updated token"
    }
    @invalid_attrs %{
      email: "teste@teste",
      first_name: nil,
      image: nil,
      last_name: nil,
      provider: nil,
      token: nil
    }

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user_fixture()
      assert Accounts.list_users() |> Enum.count() == 3
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.first_name == "some first_name"
      assert user.image == "some image"
      assert user.last_name == "some last_name"
      assert user.provider == "some provider"
      assert user.token == "some token"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "create_user/1 with invalid data returns error datacase" do
      assert {:error, changeset} = Accounts.create_user(@invalid_attrs)
      assert "can't be blank" in errors_on(changeset).provider
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.first_name == "some updated first_name"
      assert user.image == "some updated image"
      assert user.last_name == "some updated last_name"
      assert user.provider == "some updated provider"
      assert user.token == "some updated token"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
