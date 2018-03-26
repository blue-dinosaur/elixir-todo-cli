defmodule Parser do

  @moduledoc """
  Este módulo obtem comandos a partir de strings.
  A checagem de tipo dos comandos que requerem um id numérico
  é feita aqui.
  """

  def parse_command("quit"), do: :quit
  def parse_command("list"), do: :list
  def parse_command("add " <> description), do: {:add, description}

  def parse_command("delete " <> id) do
    case Integer.parse(id) do
      {id_num, ""} -> {:delete, id_num}
      _ -> {:parse_error, "Id must be an integer"}
    end
  end

  def parse_command("check " <> id) do
    case Integer.parse(id) do
      {id_num, ""} -> {:check, id_num}
      _ -> {:parse_error, "Id must be an integer"}
    end
  end

  def parse_command("uncheck " <> id) do
    case Integer.parse(id) do
      {id_num, ""} -> {:uncheck, id_num}
      _ -> {:parse_error, "Id must be an integer"}
    end
  end

  def parse_command(_), do: {:parse_error, "Command not understood"}
end
