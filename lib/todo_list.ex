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

  def set_checked(todo_list, id, checked) when is_map(todo_list) do
    if Map.has_key?(todo_list, id) do
      Map.update!(todo_list, id, fn todo ->
        %{todo | checked: false}
      end)
    else
      todo_list
    end
  end

  def delete(todo_list, id) when is_map(todo_list) do
    Map.delete(todo_list, id)
  end

  def get_next_id(todo_list) when is_map(todo_list) do
    next_id = 1 + (todo_list |> Map.keys() |> Enum.count())
  end
end
