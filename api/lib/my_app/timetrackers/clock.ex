defmodule MyApp.TimeTrackers.Clock do
  use Ecto.Schema
  import Ecto.Changeset
  alias MyApp.Accounts.User

  schema "clocks" do
    field :status, :boolean, default: false
    field :time, :naive_datetime
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :user])
    |> validate_required([:time, :status, :user])
  end
end
