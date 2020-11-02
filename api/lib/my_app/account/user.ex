defmodule MyApp.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias MyApp.Account.Clock

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string
    field :firstname, :string
    field :lastname, :string
    has_many :clocks, Clock

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :firstname, :lastname])
    |> validate_required([:username, :email, :password])
    |> validate_format(:email, ~r/(\w+)@([\w+)\.([\w.]{2,4})/)
    |> validate_length(:password, min: 8)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end
end
