defmodule MyAppWeb.TokenView do
    use MyAppWeb, :view

    def render("token.json", %{status: status, token: token, user: user}) do
        %{status: status,
        token: token,
        user: user}
    end
end