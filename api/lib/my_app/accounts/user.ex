defmodule MyApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias MyApp.TimeTrackers.Clock
  alias MyApp.TimeTrackers.Workingtime

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :username, :string
    has_many :workingtimes, Workingtime
    has_many :clocks, Clock

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :firstname, :lastname, :password, :email])
    |> validate_required([:username, :firstname, :lastname, :password, :email])
    |> validate_format(:email, ~r/(\w+)@([\w+)\.([\w.]{2,4})/)
    |> validate_length(:password, min: 8)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> put_hashed_password
  end

  defp put_hashed_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}}
        ->
          put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
          changeset
    end
  end
end
