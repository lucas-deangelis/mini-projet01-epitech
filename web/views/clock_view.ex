defmodule GothamWeb.ClockView do
  use GothamWeb, :view
  alias GothamWeb.ClockView

  def render("show.json", %{clock: clock}) do
    %{data: render_one(clock, ClockView, "clock.json")}
  end

  def render("clock.json", %{clock: clock}) do
    %{id: clock.id,
      time: clock.time,
      status: clock.status,
      user: clock.user
    }
  end
end
