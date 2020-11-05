defmodule MyAppWeb.ClockView do
  use MyAppWeb, :view
  alias MyAppWeb.ClockView
  alias MyAppWeb.UserView

  def render("index.json", %{clocks: clocks}) do
    %{data: render_many(clocks, ClockView, "clock.json")}
  end

  def render("show.json", %{clock: clock}) do
    %{data: render_one(clock, ClockView, "clock.json")}
  end

  def render("clock.json", %{clock: clock}) do
    %{id: clock.id,
      time: clock.time,
      status: clock.status,
      user: render_one(clock.user, UserView, "user.json"),
      creation_date: NaiveDateTime.to_string(clock.inserted_at)}
  end

  def render("clockWithUser.json", %{clock: clock, user: user}) do
    %{id: clock.id,
      time: clock.time,
      status: clock.status,
      user: render_one(user, UserView, "user.json"),
      creation_date: NaiveDateTime.to_string(clock.inserted_at)}
  end
end
