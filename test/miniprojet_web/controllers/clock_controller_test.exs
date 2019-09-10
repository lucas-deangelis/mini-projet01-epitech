defmodule GothamWeb.ClockControllerTest do
  use GothamWeb.ConnCase

  alias Gotham.Accounts
  alias Gotham.Accounts.Clock

  @create_attrs %{
    status: true,
    time: ~N[2010-04-17 14:00:00]
  }
  @update_attrs %{
    status: false,
    time: ~N[2011-05-18 15:01:01]
  }
  @invalid_attrs %{status: nil, time: nil}

  def fixture(:clock) do
    {:ok, clock} = Accounts.create_clock(@create_attrs)
    clock
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all clocks", %{conn: conn} do
      conn = get(conn, Routes.clock_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create clock" do
    test "renders clock when data is valid", %{conn: conn} do
      conn = post(conn, Routes.clock_path(conn, :create), clock: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.clock_path(conn, :show, id))

      assert %{
               "id" => id,
               "status" => true,
               "time" => "2010-04-17T14:00:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.clock_path(conn, :create), clock: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update clock" do
    setup [:create_clock]

    test "renders clock when data is valid", %{conn: conn, clock: %Clock{id: id} = clock} do
      conn = put(conn, Routes.clock_path(conn, :update, clock), clock: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.clock_path(conn, :show, id))

      assert %{
               "id" => id,
               "status" => false,
               "time" => "2011-05-18T15:01:01"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, clock: clock} do
      conn = put(conn, Routes.clock_path(conn, :update, clock), clock: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete clock" do
    setup [:create_clock]

    test "deletes chosen clock", %{conn: conn, clock: clock} do
      conn = delete(conn, Routes.clock_path(conn, :delete, clock))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.clock_path(conn, :show, clock))
      end
    end
  end

  defp create_clock(_) do
    clock = fixture(:clock)
    {:ok, clock: clock}
  end
end
