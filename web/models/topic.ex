defmodule Discuss.Topic do
  use Discuss.Web, :model

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "topics" do
    field(:title, :string)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
