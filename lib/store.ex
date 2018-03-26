defmodule Store do

  def encode(todos) when is_map(todos) do
    make_records(todos)
    |> Poison.encode!()
  end

  def make_records(todos) when is_map(todos) do
    todos
    |> Map.to_list()
    |> Enum.map(fn {id, todo} ->
      %{id: id, description: todo.description, checked: todo.checked}
    end)
  end

  def decode(raw) when is_binary(raw) do
    raw
    |> Poison.decode!(keys: :atoms)
    |> Enum.reduce(%{}, fn record, store ->
      %{id: id, description: description, checked: checked} = record
      Map.put(store, id, %{description: description, checked: checked})
    end)
  end
end
