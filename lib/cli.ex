defmodule CLI do

  @moduledoc """
  Este módulo tem o ponto de entrada do programa (`main`), que
  parametriza e repete o loop principal.
  """

  import Parser
  import Command
  import Store

  def main(args) do

    reader = fn -> IO.gets("\n>> ") end
    writer = fn s -> IO.puts(s) end
    file_reader = fn -> File.read!("todos.json") end
    file_writer = fn r -> File.write!("todos.json", r) end

    result = loop(reader, writer, file_reader, file_writer)

    if result == :quit do
      IO.puts("Goodbye")
    else
      main(args)
    end
  end

  def loop(console_reader, console_writer, file_reader, file_writer) do
    command = console_reader.() |> String.trim() |> parse_command

    if command == :quit do
      :quit
    else
      state = file_reader.() |> Store.decode
      {next_state, messages} = run_command_on_state(state, command)
      for m <- messages, do: console_writer.(m)
      next_state |> encode |> file_writer.()
      :continue
    end
  end

end
