defmodule TodoListTest do
  use ExUnit.Case

  test "add/2" do
    todo_list =
      %{}
      |> TodoList.add("foo")
      |> TodoList.add("bar")

    assert todo_list == %{
             1 => %{checked: false, description: "foo"},
             2 => %{checked: false, description: "bar"}
           }
  end

  test "check/2" do
    todo_list =
      %{}
      |> TodoList.add("foo")
      |> TodoList.add("bar")
      |> TodoList.check(2)

    assert todo_list == %{
             1 => %{checked: false, description: "foo"},
             2 => %{checked: true, description: "bar"}
           }
  end

  test "uncheck/2" do
    todo_list = %{
      1 => %{checked: false, description: "foo"},
      2 => %{checked: true, description: "bar"}
    }

    todo_list = todo_list |> TodoList.uncheck(2)

    assert todo_list == %{
             1 => %{checked: false, description: "foo"},
             2 => %{checked: false, description: "bar"}
           }
  end

  test "delete/2" do
    todo_list = %{
      1 => %{checked: false, description: "foo"},
      2 => %{checked: true, description: "bar"}
    }

    todo_list = todo_list |> TodoList.delete(2)

    assert todo_list == %{
             1 => %{checked: false, description: "foo"}
           }
  end

  test "show_todo/2" do
    todo_list = %{
      1 => %{checked: false, description: "foo"},
      2 => %{checked: true, description: "bar"}
    }

    assert TodoList.show_todo(todo_list, 1) == "TO-DO: foo (1)"
    assert TodoList.show_todo(todo_list, 2) == "DONE:  bar (2)"
  end

  test "get_next_id/1" do
    todo_list = %{
      1 => nil,
      3 => nil,
      10 => nil
    }

    assert TodoList.get_next_id(todo_list) == 11
  end
end
