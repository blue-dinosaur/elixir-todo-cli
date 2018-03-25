defmodule CommandTest do
  use ExUnit.Case

  test "exec_command/2 (list)" do
    todo_list = %{} |> TodoList.add("Foo") |> TodoList.add("Bar") |> TodoList.check(2)
    expected_result = [print: "TO-DO: Foo (1)", print: "DONE:  Bar (2)"]
    unit = Command.exec_command(todo_list, ["list"])
    assert expected_result == unit
  end

  test "exec_command/2 (add)" do
    todo_list = %{}
    expected_result = [print: "Todo created", save: %{1 => %{description: "Foo", checked: false}}]
    unit = todo_list |> Command.exec_command(["add", "Foo"])
    assert expected_result == unit
  end

end
