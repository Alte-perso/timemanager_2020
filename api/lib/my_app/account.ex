defmodule MyApp.Account do
  @moduledoc """
  The Account context.
  """

  import Ecto.Query, warn: false
  alias MyApp.Repo

  alias MyApp.Account.{User, Clock, Workingtime, Team}

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
# -------------------------- User ---------------------------
  def list_users(params) do
    IO.inspect(params)
    query = from i in User
    if (params["email"]) do
      query = from i in User, where: i.email == ^params["email"]
      if (params["username"]) do
        query = from i in User, where: i.email == ^params["email"], where: i.username == ^params["username"]
        Repo.all(query)
        |> Repo.preload(:clocks) 
        |> Repo.preload(:workingtimes) 
      else
        Repo.all(query)
        |> Repo.preload(:clocks)
        |> Repo.preload(:workingtimes) 
      end
    else
      if (params["username"]) do
        query = from i in User, where: i.username == ^params["username"]
        Repo.all(query)
        |> Repo.preload(:clocks)
        |> Repo.preload(:workingtimes) 
      else
        Repo.all(query)
        |> Repo.preload(:clocks)
        |> Repo.preload(:workingtimes) 
      end
    end
  end
  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
    User
    |> Repo.get!(id)
    |> Repo.preload(:clocks)
    |> Repo.preload(:workingtimes) 
  end

  def get_user_login(username, password) do
    password_hash = Base.encode16(:crypto.hash(:sha256,  "#{password}_s3cr3tp4s$xXxX_______try_to_crack_this_lol"))
    query = from u in User, where: u.username == ^username, where: u.password_hash == ^password_hash
    Repo.all(query)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end



  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%Workingtime{}, ...]

  """
# ------------------------- Workingtime -----------------------
  def list_workingtimes do
    Workingtime
    |> Repo.all()
    |> Repo.preload(:user)
  end

  def list_workingtimes(params) do
    if (params["start"]) do
      if (params["end"]) do
        Workingtime
        |> where([w], w.start >= ^params["start"])
        |> where([w], w.end <= ^params["end"])
        |> Repo.all()
        |> Repo.preload(:user)
      else
        Workingtime
        |> where([w], w.start >= ^params["start"])
        |> Repo.all()
        |> Repo.preload(:user)
      end
    else
      if (params["end"]) do
        Workingtime
        |> where([w], w.end <= ^params["end"])
        |> Repo.all()
        |> Repo.preload(:user)
      else
        Workingtime
        |> Repo.all()
        |> Repo.preload(:user)
      end
    end
  end
  @doc """
  Gets a single workingtime.

  Raises `Ecto.NoResultsError` if the Workingtime does not exist.

  ## Examples

      iex> get_workingtime!(123)
      %Workingtime{}

      iex> get_workingtime!(456)
      ** (Ecto.NoResultsError)

  """
  def get_workingtime!(id) do
    Workingtime
    |> Repo.get!(id)
    |> Repo.preload(:user)

  end

  def get_workingtime_by_user!(id) do
    Workingtime
    |> where([w], w.user_id == ^id)
    |> Repo.all()
    |> Repo.preload(:user)
  end

  def get_workingtime_by_user!(id, params) do
    if (params["start"]) do
      if (params["end"]) do
        Workingtime
        |> where([w], w.user_id == ^id)
        |> where([w], w.start >= ^params["start"])
        |> where([w], w.end <= ^params["end"])
        |> Repo.all()
        |> Repo.preload(:user)
      else
        Workingtime
        |> where([w], w.user_id == ^id)
        |> where([w], w.start >= ^params["start"])
        |> Repo.all()
        |> Repo.preload(:user)
      end
    else
      if (params["end"]) do
        Workingtime
        |> where([w], w.user_id == ^id)
        |> where([w], w.end <= ^params["end"])
        |> Repo.all()
        |> Repo.preload(:user)
      else
        Workingtime
        |> where([w], w.user_id == ^id)
        |> Repo.all()
        |> Repo.preload(:user)
      end
    end
  end

  @doc """
  Creates a workingtime.

  ## Examples

      iex> create_workingtime(%{field: value})
      {:ok, %Workingtime{}}

      iex> create_workingtime(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  # def create_workingtime(attrs \\ %{}) do
  #   %Workingtime{}
  #   |> Workingtime.changeset(attrs)
  #   |> Repo.insert()
  # end

  def create_workingtime_for_user(%User{} = user, attrs \\ %{}) do
    user
      |> Ecto.build_assoc(:workingtimes)
      |> Workingtime.changeset(attrs)
      |> Repo.insert()
  end

  def create_auto_workingtime(userId, clockStart, clockEnd) do
    new_workingtime = %{start: clockStart, end: clockEnd, user: userId}
    %Workingtime{}
    |> Workingtime.changeset(new_workingtime)
    |> Repo.insert()
end

  @doc """
  Updates a workingtime.

  ## Examples

      iex> update_workingtime(workingtime, %{field: new_value})
      {:ok, %Workingtime{}}

      iex> update_workingtime(workingtime, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_workingtime(%Workingtime{} = workingtime, attrs) do
    workingtime
    |> Workingtime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a workingtime.

  ## Examples

      iex> delete_workingtime(workingtime)
      {:ok, %Workingtime{}}

      iex> delete_workingtime(workingtime)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workingtime(%Workingtime{} = workingtime) do
    Repo.delete(workingtime)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workingtime changes.

  ## Examples

      iex> change_workingtime(workingtime)
      %Ecto.Changeset{data: %Workingtime{}}

  """
  def change_workingtime(%Workingtime{} = workingtime) do
    Workingtime.changeset(workingtime, %{})
  end



  @doc """
  Returns the list of clocks.

  ## Examples

      iex> list_clocks()
      [%Clock{}, ...]

  """
# -------------------------- Clock ---------------------------

def list_clocks do
    Clock
    |> Repo.all()
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single clock.

  Raises `Ecto.NoResultsError` if the Clock does not exist.

  ## Examples

      iex> get_clock!(123)
      %Clock{}

      iex> get_clock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clock!(id) do
    Clock
    |> Repo.get!(id)
    |> Repo.preload(:user)
  end

  def get_clock_by_user!(id) do
    Clock
    |> where([c], c.user_id == ^id)
    |> Repo.all()
    |> Repo.preload(:user)
  end

  @doc """
  Creates a clock.

  ## Examples

      iex> create_clock(%{field: value})
      {:ok, %Clock{}}

      iex> create_clock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def create_clock_for_user(%User{} = user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:clocks)
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end

  def check_endclock_create_workingtime(clock) do
    if (clock.status == true) do
      user = clock.user
      query = from i in Clock, where: i.user == ^user, where: i.status == true, order_by: i.time
      last_clocks = Repo.all(query)
      last_clock = List.first(last_clocks)
      startClock = last_clock.time
      endClock = clock.time
      if (clock != last_clock) do
        new_params = %{time: last_clock.time, status: false, user: last_clock.user}
        last_clock
        |> Clock.changeset(new_params)
        |> Repo.update()
        new_params = %{time: clock.time, status: false, user: clock.user}
        clock
        |> Clock.changeset(new_params)
        |> Repo.update()
        create_auto_workingtime(clock.user, startClock, endClock)
      end
    end
end

  @doc """
  Updates a clock.

  ## Examples

      iex> update_clock(clock, %{field: new_value})
      {:ok, %Clock{}}

      iex> update_clock(clock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clock(%Clock{} = clock, attrs) do
    clock
    |> Clock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a clock.

  ## Examples

      iex> delete_clock(clock)
      {:ok, %Clock{}}

      iex> delete_clock(clock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clock(%Clock{} = clock) do
    Repo.delete(clock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clock changes.

  ## Examples

      iex> change_clock(clock)
      %Ecto.Changeset{data: %Clock{}}

  """
  def change_clock(%Clock{} = clock) do
    Clock.changeset(clock, %{})
  end

  @doc """
  Returns the list of teams.

  ## Examples

      iex> list_teams()
      [%Team{}, ...]

  """
# -------------------------- TEAM -----------------------------

  def list_teams do
    Team
    |> Repo.all()
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team!(id) do
    Team
    |> Repo.get!(id)
    |> Repo.preload(:user)
  end

  def get_team_by_user!(id) do
    Team
    |> where([t], t.user_id == ^id)
    |> Repo.all()
    |> Repo.preload(:user)
  end

  @doc """
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  def create_team_for_user(%User{} = user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:teams)
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a team.

  ## Examples

      iex> update_team(team, %{field: new_value})
      {:ok, %Team{}}

      iex> update_team(team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a team.

  ## Examples

      iex> delete_team(team)
      {:ok, %Team{}}

      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{data: %Team{}}

  """
  def change_team(%Team{} = team, attrs \\ %{}) do
    Team.changeset(team, attrs)
  end
end
