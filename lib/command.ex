defmodule Command do
  import TodoList

  def run_command_on_state(todo_list, command) do
    case command do
      :list -> cmd_list(todo_list)
      {:add, description} -> cmd_add(todo_list, description)
      {:check, id} -> cmd_check(todo_list, id)
      {:uncheck, id} -> cmd_uncheck(todo_list, id)
      {:delete, id} -> cmd_delete(todo_list, id)
    end
  end

  # Server API

  def cmd_add(todo_list, description) do
    next_state = add(todo_list, description)
    {next_state, ["Todo created"]}
  end

  def cmd_list(todo_list) do
    if todo_list == %{} do
      {todo_list, ["No todos"]}
    else
      messages =
        todo_list
        |> Map.keys()
        |> Enum.map(&show_todo(todo_list, &1))

      {todo_list, messages}
    end
  end

  def cmd_check(todo_list, id) do
    if Map.has_key?(todo_list, id) do
      {check(todo_list, id), ["Todo checked"]}
    else
      {todo_list, ["No todo with id #{id}"]}
    end
  end

  def cmd_uncheck(todo_list, id) do
    if Map.has_key?(todo_list, id) do
      {uncheck(todo_list, id), ["Todo unchecked"]}
    else
      {todo_list, ["No todo with id #{id}"]}
    end
  end

  def cmd_delete(todo_list, id) do
    if Map.has_key?(todo_list, id) do
      {delete(todo_list, id), ["Todo deleted"]}
    else
      {todo_list, ["No todo with id #{id}"]}
    end
  end
end
