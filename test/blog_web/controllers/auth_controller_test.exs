defmodule BlogWeb.AuthControllerTest do
  use BlogWeb.ConnCase

  @ueberauth %Ueberauth.Auth{
    credentials: %{
      token: "123"
    },
    info: %{
      email: "teste@teste",
      first_name: "Gustavo",
      last_name: "Oliveira",
      image: "123123123213123213"
    },
    provider: "google"
  }

  @ueberauth_error %{
    credentials: %{
      token: nil
    },
    info: %{
      email: "teste@teste",
      first_name: nil,
      last_name: nil,
      image: nil
    },
    provider: nil
  }

  test "callback success", %{conn: conn} do
    conn =
      conn
      |> assign(:ueberauth_auth, @ueberauth)
      |> get(Routes.auth_path(conn, :callback, "google"))

    assert redirected_to(conn) == Routes.page_path(conn, :index)
    conn = get(conn, Routes.page_path(conn, :index))
    assert html_response(conn, 200) =~ "Bem vindo!!! #{@ueberauth.info.email}"
  end

  test "request test", %{conn: conn} do
    conn =
      conn
      |> get(Routes.auth_path(conn, :request, "google"))

    assert redirected_to(conn) =~ "accounts.google.com"
  end

  test "callback error", %{conn: conn} do
    conn =
      conn
      |> assign(:ueberauth_auth, @ueberauth_error)
      |> get(Routes.auth_path(conn, :callback, "google"))

    assert redirected_to(conn) == Routes.page_path(conn, :index)
    conn = get(conn, Routes.page_path(conn, :index))
    assert html_response(conn, 200) =~ "Algo deu Errado"
  end

  test "logout success", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 2)
      |> get(Routes.auth_path(conn, :logout))

    assert redirected_to(conn) == Routes.page_path(conn, :index)
  end
end
