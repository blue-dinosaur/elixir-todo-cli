defmodule TodoList do
  def add(todo_list, description) when is_map(todo_list) do
    next_id = get_next_id(todo_list)
    todo = %{description: description, checked: false}
    Map.put(todo_list, next_id, todo)
  end

  def check(todo_list, id) when is_map(todo_list) do
    set_checked(todo_list, id, true)
  end

  def uncheck(todo_list, id) when is_map(todo_list) do
    set_checked(todo_list, id, false)
  end

  def delete(todo_list, id) when is_map(todo_list) do
    Map.delete(todo_list, id)
  end

  def get_next_id(todo_list) when is_map(todo_list) do
    if todo_list == %{} do
      1
    else
      1 + (todo_list |> Map.keys() |> Enum.max())
    end
  end

  def show_todo(todo_list, id) do
    case Map.get(todo_list, id) do
      %{checked: true, description: description} ->
        "DONE:  #{description} (#{id})"

      %{checked: false, description: description} ->
        "TO-DO: #{description} (#{id})"
    end
  end

  defp set_checked(todo_list, id, checked) when is_map(todo_list) do
    Map.update!(todo_list, id, fn todo ->
      %{todo | checked: checked}
    end)
  end
end
