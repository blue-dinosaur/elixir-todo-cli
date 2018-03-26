defmodule CommandTest do
  use ExUnit.Case

  test "run_command_on_state/2, list" do
    todo_list = %{} |> TodoList.add("Foo") |> TodoList.add("Bar")
    {_, messages} = Command.run_command_on_state(todo_list, :list)
    assert messages == ["TO-DO: Foo (1)", "TO-DO: Bar (2)"]
  end

  test "run_command_on_state/2, empty list" do
    todo_list = %{}
    {_, messages} = Command.run_command_on_state(todo_list, :list)
    assert messages == ["No todos"]
  end

  test "run_command_on_state/2, add" do
    todo_list = %{}
    {result, messages} = Command.run_command_on_state(todo_list, {:add, "Foo"})
    assert result == %{1 => %{description: "Foo", checked: false}}
    assert messages == ["Todo created"]
  end

  test "run_command_on_state/2, check" do
    todo_list = TodoList.add(%{}, "Foo")
    {result, messages} = Command.run_command_on_state(todo_list, {:check, 1})
    assert result == %{1 => %{description: "Foo", checked: true}}
    assert messages == ["Todo checked"]
  end

  test "run_command_on_state/2, check, id not found" do
    todo_list = TodoList.add(%{}, "Foo")
    {result, messages} = Command.run_command_on_state(todo_list, {:check, 2})
    assert result == %{1 => %{description: "Foo", checked: false}}
    assert messages == ["No todo with id 2"]
  end

  test "run_command_on_state/2, uncheck" do
    todo_list = TodoList.add(%{}, "Foo") |> TodoList.check(1)
    {result, messages} = Command.run_command_on_state(todo_list, {:uncheck, 1})
    assert result == %{1 => %{description: "Foo", checked: false}}
    assert messages == ["Todo unchecked"]
  end

  test "run_command_on_state/2, uncheck, id not found" do
    todo_list = TodoList.add(%{}, "Foo")
    {result, messages} = Command.run_command_on_state(todo_list, {:uncheck, 2})
    assert result == %{1 => %{description: "Foo", checked: false}}
    assert messages == ["No todo with id 2"]
  end

  test "run_command_on_state/2, delete" do
    todo_list = TodoList.add(%{}, "Foo")
    {result, messages} = Command.run_command_on_state(todo_list, {:delete, 1})
    assert result == %{}
    assert messages == ["Todo deleted"]
  end

  test "run_command_on_state/2, delete, id not found" do
    todo_list = TodoList.add(%{}, "Foo")
    {result, messages} = Command.run_command_on_state(todo_list, {:delete, 2})
    assert result == todo_list
    assert messages == ["No todo with id 2"]
  end
end
