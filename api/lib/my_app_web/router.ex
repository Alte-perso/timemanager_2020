defmodule MyAppWeb.Router do
  use MyAppWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/api", MyAppWeb do
    pipe_through :api
    
    resources "/users", UserController, except: [:new, :edit]
    options   "/users", UserController, :options
    options   "/users/:id", UserController, :options

    resources "/clocks", ClockController, except: [:new, :edit]
    options   "/clocks", ClockController, :options
    options   "/clocks/:id", ClockController, :options
    post      "/clocks/:id", ClockController, :create_for_user
    options   "/clocks/:id/last", ClockController, :options
    get       "/clocks/:id/last", ClockController, :show_last_clock

    resources "/workingtimes", WorkingtimeController, except: [:new, :edit]
    options   "/workingtimes", WorkingtimeController, :options
    options   "/workingtimes/:id", WorkingtimeController, :options
    get       "/workingtimes/:id/:idi", WorkingtimeController, :show_one
    post      "/workingtimes/:id", WorkingtimeController, :create_for_user

    resources "/teams", TeamController, except: [:new, :edit]
    options   "/teams", TeamController, :options
    options   "/teams/:id", TeamController, :options
    post      "/teams/:id", TeamController, :create_for_user
  end

  pipeline :auth do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/auth", MyAppWeb do
    pipe_through :auth

    options   "/", TokenController, :options
    post      "/", TokenController, :login
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
end
