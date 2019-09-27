defmodule GothamWeb.ClockControllerTest do
  use GothamWeb.ConnCase

  alias GothamWeb.Router
  alias Gotham.Times
  alias Gotham.Times.Clock

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
    {:ok, clock} = Times.create_clock(@create_attrs)
    clock
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "clock" do
    test "renders clock when data is valid", %{conn: conn} do
      conn = post(conn, Router.Helpers.clock_path(conn, :score), userId: 1)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Router.Helpers.clock_path(conn, :show, id))

      assert %{
               "id" => id,
               "status" => true,
               "time" => "2010-04-17T14:00:00",
               "user_id" => 1
             } = json_response(conn, 200)["data"]
    end
  end

  defp create_clock(_) do
    clock = fixture(:clock)
    {:ok, clock: clock}
  end
end
