defmodule MyApp.Token do
    use Joken.Config
    import Plug.Conn

    def init(opts) do
        opts
    end

    def call(conn, _opts) do
        tkn = jwt_from_header(conn)
        case Token.verify_and_validate(tkn) do
            {:error, _error} -> forbidden(conn)
            {:ok, claims} -> success(conn, claims, tkn)
        end
    end

    def jwt_from_header(conn) do
        tmp = List.last(get_req_header(conn, "session_jwt"))
        if (is_nil(tmp)) do
            ""
        else
            tmp
        end
    end

    defp success(conn, claims, token) do
        conn
        |> assign(:user, claims["user"])
        |> assign(:jwt, token)
    end

    defp forbidden(conn) do
        conn
        |> send_resp(403, "{forbidden}")
        |> halt
    end
end