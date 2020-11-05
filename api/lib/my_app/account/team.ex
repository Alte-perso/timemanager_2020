defmodule MyApp.Account.Team do
  use Ecto.Schema
  import Ecto.Changeset
  alias MyApp.Account.User

  schema "teams" do
    field :name, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
