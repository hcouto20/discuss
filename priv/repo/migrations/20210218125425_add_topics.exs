defmodule Discuss.Repo.Migrations.AddTopics do
  use Ecto.Migration

  def change do
    create table(:topics, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:title, :string)
    end
  end
end
