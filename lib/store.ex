defmodule Store do
  def load do
    case File.read("todos.json") do
      {:ok, raw} -> decode(raw)
      :enoent -> %{}
      other_error -> raise other_error
    end
  end

  def save(todos) do
    todos_records =
      todos
      |> Map.to_list()
      |> Enum.map(fn {id, todo} ->
        %{id: id, description: todo.description, checked: todo.checked}
      end)
      |> Poison.encode!()

    File.write!("todos.json", todos_records)
  end

  def decode(raw) do
    raw
    |> Poison.decode!(keys: :atoms)
    |> Enum.reduce(%{}, fn record, store ->
      %{id: id, description: description, checked: checked} = record
      Map.put(store, id, %{description: description, checked: checked})
    end)
  end
end
