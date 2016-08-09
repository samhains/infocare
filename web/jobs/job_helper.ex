defmodule InfoCare.JobsHelper do
  alias InfoCare.Repo

  import IEx
  import Logger

  def insert_or_update_record params, model, struct, query do
    insert_or_update_changeset(params, model, struct, query)
        |> Repo.insert_or_update
        |> response_handler
  end

  def insert_record params, model, struct do
    params
      |> Enum.into(struct)
      |> model.changeset(%{})
      |> Repo.insert
      |> response_handler
  end

  def insert_or_update_changeset params, model, struct, query do
    case Repo.one(query) do
      record when is_nil record ->
        params
        |> Enum.into(struct)
        |> model.changeset(%{})

      record ->
        changeset =
          record
          |> model.changeset(params)
    end
  end

  def insert_or_update_record_and_print_errors params, model, struct, query do
    case insert_or_update_record(params, model, struct, query) do
      {:ok, record} ->
        {:ok, record }
      {:error, error} ->
        Logger.error (inspect error)
        {:error, error}
    end
  end

  def response_handler response do
    case response do
      {:ok, record} ->
        {:ok, record}
      {:error, record_changeset} ->
        {:error, record_changeset.errors}
    end
  end

  def prepend_to_list_if_unique list, struct, unique_key do
    case Enum.find(list, fn(s) -> Map.get(struct, unique_key) == Map.get(s, unique_key)  end) do
      update_struct when is_nil(update_struct) ->
        [struct | list]

      _ ->
        list
    end
  end
end
