defmodule MyApp.Account.Workingtime do
  use Ecto.Schema
  import Ecto.Changeset
  alias MyApp.Account.User

  schema "workingtimes" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(workingtime, attrs) do
    workingtime
    |> cast(attrs, [:start, :end])
    |> validate_required([:start, :end])
  end
end
