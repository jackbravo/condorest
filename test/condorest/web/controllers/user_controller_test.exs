defmodule Condorest.Web.UserControllerTest do
  use Condorest.Web.ConnCase

  alias Condorest.Accounts

  @create_attrs %{name: "some name", username: "some username"}
  @update_attrs %{name: "some updated name", username: "some updated username"}
  @invalid_attrs %{name: nil, username: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} = config do
    if username = config[:login_as] do
      case Accounts.create_user(%{name: username, username: username}) do
        {:ok, user} ->
          conn = assign(build_conn(), :current_user, user)
          {:ok, conn: conn, user: user}
        {:error, error} ->
          {:error, conn: build_conn(), error: error}
      end
    else
      :ok
    end
  end

  test "require user auth on all actions", %{conn: conn} do
    Enum.each([
      get(conn, user_path(conn, :index)),
      get(conn, user_path(conn, :new)),
      get(conn, user_path(conn, :show, "123")),
      get(conn, user_path(conn, :edit, "123")),
      post(conn, user_path(conn, :create, %{})),
      put(conn, user_path(conn, :update, "123", %{})),
      delete(conn, user_path(conn, :delete, "123")),
    ], fn conn ->
      assert html_response(conn, 302)
      assert conn.halted
    end)
  end

  @tag login_as: "max"
  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Users"
  end

  @tag login_as: "max"
  test "renders form for new users", %{conn: conn} do
    conn = get conn, user_path(conn, :new)
    assert html_response(conn, 200) =~ "New User"
  end

  @tag login_as: "max"
  test "creates user and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == user_path(conn, :show, id)

    conn = get conn, user_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show User"
  end

  @tag login_as: "max"
  test "does not create user and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert html_response(conn, 200) =~ "New User"
  end

  @tag login_as: "max"
  test "renders form for editing chosen user", %{conn: conn} do
    user = fixture(:user)
    conn = get conn, user_path(conn, :edit, user)
    assert html_response(conn, 200) =~ "Edit User"
  end

  @tag login_as: "max"
  test "updates chosen user and redirects when data is valid", %{conn: conn} do
    user = fixture(:user)
    conn = put conn, user_path(conn, :update, user), user: @update_attrs
    assert redirected_to(conn) == user_path(conn, :show, user)

    conn = get conn, user_path(conn, :show, user)
    assert html_response(conn, 200) =~ "some updated name"
  end

  @tag login_as: "max"
  test "does not update chosen user and renders errors when data is invalid", %{conn: conn} do
    user = fixture(:user)
    conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit User"
  end

  @tag login_as: "max"
  test "deletes chosen user", %{conn: conn} do
    user = fixture(:user)
    conn = delete conn, user_path(conn, :delete, user)
    assert redirected_to(conn) == user_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, user_path(conn, :show, user)
    end
  end
end
