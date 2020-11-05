defmodule MyAppWeb.TeamView do
    use MyAppWeb, :view
    alias MyAppWeb.TeamView
    alias MyAppWeb.UserView

    def render("index.json", %{teams: teams}) do
        %{data: render_many(teams, TeamView, "team.json")}
    end

    def render("show.json", %{team: team}) do
        %{data: render_one(team, TeamView, "team.json")}
    end

    def render("team.json", %{team: team}) do
        %{name: team.name,
        user: render_one(team.user, UserView, "user.json"),
        creation_date: NaiveDateTime.to_string(team.inserted_at)}
    end

    def render("teamWithUser.json", %{team: team, user: user}) do
        %{name: team.name,
        user: render_one(user, UserView, "user.json"),
        creation_date: NaiveDateTime.to_string(team.inserted_at)}
    end
end