defmodule MyAppWeb.TeamController do
    use MyAppWeb, :controller

    alias MyApp.Account
    alias MyApp.Account.Team

    action_fallback MyAppWeb.FallbackController

    def index(conn, _params) do
        teams = Account.list_teams()
        render(conn, "index.json", teams: teams)
    end

    def create_for_user(conn, %{"id" => id, "team" => team_params}) do
        user = Account.get_user!(id)
        IO.inspect(user)
        if (is_nil(user)) do
            conn
            |> put_status(:not_found)
            |> put_view(MyAppWeb.ErrorView)
            |> render(:"404")
        else
            with {:ok, %Team{} = team} <- Account.create_team_for_user(user, team_params) do
                conn
                |> put_status(:created)
                |> put_resp_header("location", Routes.team_path(conn, :show, team))
                |> render("teamWithUser.json", team: team, user: user)
            end
        end
    end

    def show(conn, %{"id" => id}) do
        teams = Account.get_team_by_user!(id)
        render(conn, "index.json", teams: teams)
    end

    def update(conn, %{"id" => id, "team" => team_params}) do
        team = Account.get_team!(id)
        with {:ok, %Team{} = team} <- Account.update_team(team, team_params) do
            render(conn, "show.json", team: team)
        end
    end

    def delete(conn, %{"id" => id}) do
        team = Account.get_team!(id)
        with {:ok, %Team{}} <- Account.delete_team(team) do
            send_resp(conn, :no_content, "")
        end
    end
end