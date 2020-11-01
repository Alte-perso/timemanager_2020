defmodule MyAppWeb.WorkingtimeController do
  use MyAppWeb, :controller

  alias MyApp.TimeTrackers
  alias MyApp.TimeTrackers.Workingtime

  action_fallback MyAppWeb.FallbackController

  def index(conn, params) do
    workingtimes = TimeTrackers.list_workingtimes(params)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"workingtime" => workingtime_params}) do
    with {:ok, %Workingtime{} = workingtime} <- TimeTrackers.create_workingtime(workingtime_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def create_for_user(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    with {:ok, %Workingtime{} = workingtime} <- TimeTrackers.create_workingtime_for_user(id, workingtime_params) do
      conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
        |> render("show.json", workingtime: workingtime)
    end
  end


  def show(conn, %{"id" => id}) do
    workingtimes = TimeTrackers.get_workingtime_by_user!(id, conn.params)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def show_one(conn, %{"id" => id, "idi" => idi}) do
    workingtimes = TimeTrackers.get_workingtime_by_user!(id)
    Enum.each workingtimes, fn workingtime -> 
      if "#{workingtime.id}" == idi do
        render(conn, "show.json", workingtime: workingtime)
      end
    end
    conn
    |> put_status(:not_found)
    |> put_view(MyApp.ErrorView)
    |> render(:"404")
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = TimeTrackers.get_workingtime!(id)
    with {:ok, %Workingtime{} = workingtime} <- TimeTrackers.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = TimeTrackers.get_workingtime!(id)
    with {:ok, %Workingtime{}} <- TimeTrackers.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end
