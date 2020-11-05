defmodule MyApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :firstname, :string
      add :lastname, :string
      add :role, :string

      timestamps()
    end

    create unique_index(:users, :username)
    create unique_index(:users, :email)

    # create constraint(
    #   "users",
    #   "is_email_valid",
    #   check: "email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'"
    # )
  end
end
