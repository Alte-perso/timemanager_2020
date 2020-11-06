defmodule MyAppWeb.WorkingtimeView do
  use MyAppWeb, :view
  alias MyAppWeb.WorkingtimeView
  alias MyAppWeb.UserView

  def render("index.json", %{workingtimes: workingtimes}) do
    %{data: render_many(workingtimes, WorkingtimeView, "workingtime.json")}
  end

  def render("show.json", %{workingtime: workingtime}) do
    %{data: render_one(workingtime, WorkingtimeView, "workingtime.json")}
  end

  def render("showWorkingTime.json", %{workingtime: workingtime}) do
    %{data: render_one(workingtime, WorkingtimeView, "workingtimeUnique.json")}
  end

  def render("workingtimeUnique.json", %{workingtime: workingtime}) do
    %{id: workingtime.id,
      start: workingtime.start,
      end: workingtime.end,
      creation_date: NaiveDateTime.to_string(workingtime.inserted_at)}
  end

  def render("workingtime.json", %{workingtime: workingtime}) do
    %{id: workingtime.id,
      start: NaiveDateTime.to_string(workingtime.start),
      end: NaiveDateTime.to_string(workingtime.end),
      user: render_one(workingtime.user, UserView, "user.json"),
      creation_date: NaiveDateTime.to_string(workingtime.inserted_at)}
  end

  def render("workingtimeWithUser.json", %{workingtime: workingtime, user: user}) do
    %{id: workingtime.id,
      start: NaiveDateTime.to_string(workingtime.start),
      end: NaiveDateTime.to_string(workingtime.end),
      user: render_one(user, UserView, "user.json"),
      creation_date: NaiveDateTime.to_string(workingtime.inserted_at)}
  end
end
