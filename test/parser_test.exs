defmodule ParserTest do
  use ExUnit.Case

  import Parser

  test "parse_command(quit)" do
    assert parse_command("quit") == :quit
  end

  test "parse_command(list)" do
    assert parse_command("list") == :list
  end

  test "parse_command(add)" do
    assert parse_command("add foo") == {:add, "foo"}
  end

  test "parse_command(check)" do
    assert parse_command("check 1") == {:check, 1}
    assert parse_command("check 1a") == {:parse_error, "Id must be an integer"}
  end

  test "parse_command(uncheck)" do
    assert parse_command("uncheck 1") == {:uncheck, 1}
    assert parse_command("uncheck 1a") == {:parse_error, "Id must be an integer"}
  end

  test "parse_command(delete)" do
    assert parse_command("delete 1") == {:delete, 1}
    assert parse_command("delete 1a") == {:parse_error, "Id must be an integer"}
  end
end
