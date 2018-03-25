defmodule Command do
  import Actions
  import Store

  def list(), do: command(["list"])
  def add(description), do: command(["add", description])
  def check(id), do: command(["check", id])
  def delete(id), do: command(["delete", id])

  # Server API
  def command(args) do
    actions = Store.load() |> exec_command(args)

    case actions do
      :none ->
        nil

      actions when is_list(actions) ->
        actions
        |> Enum.each(&run_action/1)

      action ->
        run_action(action)
    end
  end

  def exec_command(todo_list, ["add", description]) do
    [
      action_print("Todo created"),
      action_save(TodoList.add(todo_list, description))
    ]
  end

  def exec_command(todo_list, ["list"]) do
    if todo_list == %{} do
      action_print("No todos")
    else
      todo_list
      |> Map.keys()
      |> Enum.map(&show_todo(todo_list, &1))
      |> Enum.map(&action_print/1)
    end
  end

  def exec_command(todo_list, ["check", id]) do
    if Map.has_key?(todo_list, id) do
      [action_print("Todo updated")]
    else
      [action_print("Id not found (#{id})")]
    end
  end

  def exec_command(todo_list, ["delete", id]) do
    # TODO
  end

  def show_todo(todo_list, id) do
    case Map.get(todo_list, id) do
      %{checked: true, description: description} ->
        "DONE:  #{description} (#{id})"

      %{checked: false, description: description} ->
        "TO-DO: #{description} (#{id})"
    end
  end
end
