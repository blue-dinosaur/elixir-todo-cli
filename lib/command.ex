defmodule Command do
  @moduledoc """
  O módulo de comando recebe um estado da lista de todos (`todo_list`)
  e um comando (já parseado) e aplica o comando.

  A função principal é a run_command_on_state, que retorna o estado
  resultante da aplicação de um comando e mensagens que serão mostradas ao
  usuário.

  Este módulo é completamente puro.

  A lógica da TodoList fica num módulo a parte,
  e idealmente não deveria ter nada que lide diretamente com a estrutura
  de dados subjacente neste modulo.
  """
  import TodoList

  def run_command_on_state(todo_list, {:parse_error, message}) do
    {todo_list, ["Error: #{message}"]}
  end
  def run_command_on_state(todo_list, command) do
    case command do
      :list -> cmd_list(todo_list)
      {:add, description} -> cmd_add(todo_list, description)
      {:check, id} -> cmd_check(todo_list, id)
      {:uncheck, id} -> cmd_uncheck(todo_list, id)
      {:delete, id} -> cmd_delete(todo_list, id)
    end
  end

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
