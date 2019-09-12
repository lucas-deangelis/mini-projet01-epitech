defmodule GothamWeb.WorkingtimeView do
  use GothamWeb, :view
  alias GothamWeb.WorkingtimeView

  def render("workingtime.json", %{workingtime: workingtime}) do
    %{id: workingtime.id,
      user: workingtime.user,
      start: workingtime.start,
      end: workingtime.end}
  end

  def render("index.json", %{workingtime: workingtime}) do
    %{data: render_many(workingtime, WorkingtimeView, "workingtime.json")}
  end

  def render("show.json", %{workingtime: workingtime}) do
    IO.inspect("inside view")
    %{data: render_one(workingtime, WorkingtimeView, "workingtime.json")}
  end


end
