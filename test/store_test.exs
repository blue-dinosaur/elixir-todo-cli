defmodule StoreTest do
  use ExUnit.Case

  import Store

  test "make_records/1" do
    todo_list =
      %{}
      |> TodoList.add("Foo")
      |> TodoList.add("Bar")
      |> TodoList.check(2)
      |> make_records

    assert todo_list == [
             %{checked: false, description: "Foo", id: 1},
             %{checked: true, description: "Bar", id: 2}
           ]
  end

  test "decode/1" do
    todo_list =
      %{}
      |> TodoList.add("Foo")
      |> TodoList.add("Bar")
      |> TodoList.check(2)

    records = todo_list |> make_records()
    raw = records |> Poison.encode!()

    assert decode(raw) == todo_list
  end

  test "encode/1 and decode/1" do
    todo_list =
      %{}
      |> TodoList.add("Foo")
      |> TodoList.add("Bar")
      |> TodoList.check(2)

    assert decode(encode(todo_list)) == todo_list
  end
end
