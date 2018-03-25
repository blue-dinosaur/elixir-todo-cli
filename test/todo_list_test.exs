defmodule TodoListTest do
  use ExUnit.Case

  test "add/2" do
    expected_result = %{1 => %{checked: false, description: "foo"}}
    unit = TodoList.add(%{}, "foo")
    assert expected_result == unit
  end

  test "check/2" do
    expected_result = %{1 => %{checked: true, description: "foo"}}
    unit = TodoList.add(%{}, "foo") |> TodoList.check(1)
    assert expected_result == unit
  end

  test "uncheck/2" do
    expected_result = %{1 => %{checked: false, description: "foo"}}
    unit = TodoList.add(%{}, "foo") |> TodoList.check(1) |> TodoList.uncheck(1)
    assert expected_result == unit
  end

  test "delete/2" do
    expected_result = %{}
    unit = TodoList.add(%{}, "foo") |> TodoList.delete(1)
    assert expected_result == unit
  end
end
