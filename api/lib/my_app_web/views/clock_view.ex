defmodule MyAppWeb.ClockView do
  use MyAppWeb, :view
  alias MyAppWeb.ClockView

  def render("index.json", %{clocks: clocks}) do
    %{data: render_many(clocks, ClockView, "clock.json")}
  end

  def render("show.json", %{clock: clock}) do
    %{data: render_one(clock, ClockView, "clock.json")}
  end

  def render("clock.json", %{clock: clock}) do
    %{id: clock.id,
      time: clock.time,
      status: clock.status}
  end

    def render("error.json", %{message: message}) do
    %{error: message}
  end
end
