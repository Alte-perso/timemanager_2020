defmodule MyAppWeb.ClockController do
  use MyAppWeb, :controller

  alias MyApp.Account
  alias MyApp.Account.Clock

  action_fallback MyAppWeb.FallbackController

  def index(conn, _params) do
    clocks = Account.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create_for_user(conn, %{"id" => id, "clock" => clock_params}) do
    user = Account.get_user!(id)
    IO.inspect(user)
    if (is_nil(user)) do
      conn
      |> put_status(:not_found)
      |> put_view(MyAppWeb.ErrorView)
      |> render(:"404")
    else
      with {:ok, %Clock{} = clock} <- Account.create_clock_for_user(user, clock_params) do
            Account.check_endclock_create_workingtime(user, clock)
            conn
            |> put_status(:created)
            |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
            |> render("clockWithUser.json", clock: clock, user: user)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    clocks = Account.get_clock_by_user!(id)
    render(conn, "index.json", clocks: clocks)
  end

  def show_last_clock(conn, %{"id" => id}) do
    last_clock = Account.get_latest_clock_by_user!(id)
    render(conn, "show.json", clock: last_clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Account.get_clock!(id)
    with {:ok, %Clock{} = clock} <- Account.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Account.get_clock!(id)
    with {:ok, %Clock{}} <- Account.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
