defmodule Actions do
  def run_action({:print, message}) do
    IO.puts(message)
  end

  def run_action({:save, state}) do
    Store.save(state)
  end

  def action_print(message) do
    {:print, message}
  end

  def action_save(state) do
    {:save, state}
  end
end
