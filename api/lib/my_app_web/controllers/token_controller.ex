defmodule MyAppWeb.TokenController do
    use MyAppWeb, :controller
    alias MyApp.{Token, Account}

    action_fallback MyAppWeb.FallbackController

    def login(conn, params) do
        user = List.last(Account.get_user_login(params["auth"]["username"], params["auth"]["password"]))
        if (is_nil(user)) do
            render(conn, "token.json", %{status: false, token: "", user: nil})
        else
            token = Token.generate_and_sign!(%{"user" => user.id})
            render(conn, "token.json", %{status: true, token: token, user: user.id})
        end
    end
end