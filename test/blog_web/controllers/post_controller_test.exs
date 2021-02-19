defmodule BlogWeb.PostControllerTest do
  use BlogWeb.ConnCase

  @valid_post %{
    title: "Phoenix Framework",
    description: "Lorem"
  }

  @update_post %{
    title: "update 123123",
    description: "update"
  }

  def fixture(:post) do
    user = Blog.Accounts.get_user!(1)
    {:ok, post} = Blog.Posts.create_post(user, @valid_post)
    post
  end

  test "listar todos os posts", %{conn: conn} do
    user = Blog.Accounts.get_user!(1)
    Blog.Posts.create_post(user, @valid_post)

    conn =
      conn
      |> Plug.Test.init_test_session(user_id: user.id)
      |> get(Routes.post_path(conn, :index))

    assert html_response(conn, 200) =~ "Phoenix Framework"
  end

  test "pegar um post por id", %{conn: conn} do
    user = Blog.Accounts.get_user!(1)
    {:ok, post} = Blog.Posts.create_post(user, @valid_post)
    conn = get(conn, Routes.post_path(conn, :show, post))
    assert html_response(conn, 200) =~ "Phoenix Framework"
  end

  test "entrar no formulario de criacao de posts", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> get(Routes.post_path(conn, :new))

    assert html_response(conn, 200) =~ "Criar Post"
  end

  test "entrar no formulario de criacao de posts sem usuario autenticado", %{conn: conn} do
    conn =
      conn
      |> get(Routes.post_path(conn, :new))

    assert redirected_to(conn) == Routes.page_path(conn, :index)
    conn = get(conn, Routes.page_path(conn, :index))
    assert html_response(conn, 200) =~ "Voce Precisa estar Logado!!"
  end

  test "entrar no formulario de alteracao de posts", %{conn: conn} do
    user = Blog.Accounts.get_user!(1)
    {:ok, post} = Blog.Posts.create_post(user, @valid_post)

    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> get(Routes.post_path(conn, :edit, post))

    assert html_response(conn, 200) =~ "Editar Post"
  end

  test "deve lancar erro ao entrar no formulario de alteracao de posts", %{conn: conn} do
    user = Blog.Accounts.get_user!(1)
    {:ok, post} = Blog.Posts.create_post(user, @valid_post)

    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 2)
      |> get(Routes.post_path(conn, :edit, post))

    assert redirected_to(conn) == Routes.page_path(conn, :index)
    conn = get(conn, Routes.page_path(conn, :index))
    assert html_response(conn, 200) =~ "Voce nao tem permissao para esta operacao"
  end

  test "criar um post", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> post(Routes.post_path(conn, :create), post: @valid_post)

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == Routes.post_path(conn, :show, id)

    conn = get(conn, Routes.post_path(conn, :show, id))
    assert html_response(conn, 200) =~ "Phoenix Framework"
  end

  test "criar um post com valores invalidos", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> post(Routes.post_path(conn, :create), post: %{})

    assert html_response(conn, 200) =~ "campo obrigatorio"
  end

  describe "depende de post criado os testes abaixo" do
    setup [:criar_post]

    test "alterar um post", %{conn: conn, post: post} do
      conn =
        conn
        |> Plug.Test.init_test_session(user_id: 1)
        |> put(Routes.post_path(conn, :update, post), post: @update_post)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.post_path(conn, :show, id)

      conn = get(conn, Routes.post_path(conn, :show, id))
      assert html_response(conn, 200) =~ "update 123123"
    end

    test "alterar um post com valores invalidos", %{conn: conn, post: post} do
      conn =
        conn
        |> Plug.Test.init_test_session(user_id: 1)
        |> put(Routes.post_path(conn, :update, post), post: %{title: nil, description: nil})

      assert html_response(conn, 200) =~ "Editar Post"
    end

    test "delete", %{conn: conn, post: post} do
      conn =
        conn
        |> Plug.Test.init_test_session(user_id: 1)
        |> delete(Routes.post_path(conn, :delete, post))

      assert redirected_to(conn) == Routes.post_path(conn, :index)

      assert_error_sent 404, fn -> get(conn, Routes.post_path(conn, :show, post)) end
    end
  end

  defp criar_post(_) do
    %{post: fixture(:post)}
  end
end
