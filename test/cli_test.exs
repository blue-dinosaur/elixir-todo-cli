defmodule CliTest do
  use ExUnit.Case

  import CLI

  test "loop/4" do
  	{:ok, console_writer_agent} = Agent.start_link (fn -> nil end)
  	{:ok, file_writer_agent} = Agent.start_link (fn -> nil end)
  	console_reader = fn -> "list" end
  	console_writer = (fn s ->
  		Agent.update(console_writer_agent, fn _ ->
  			s
  		end)
  	end)
  	file_reader = fn -> "[{\"description\":\"A task\",\"id\":1,\"checked\": false}]" end
  	file_writer = (fn s ->
  		Agent.update(file_writer_agent, fn _ ->
  			s
  		end)
  	end)
  	assert loop(console_reader, console_writer, file_reader, file_writer) == :continue
  	assert Agent.get(console_writer_agent, fn x -> x end) == "TO-DO: A task (1)"
  	assert Agent.get(file_writer_agent, fn x -> x end) == "[{\"id\":1,\"description\":\"A task\",\"checked\":false}]"
  end

end
