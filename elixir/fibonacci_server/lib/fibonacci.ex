defmodule Fibonacci do
  alias Fibonacci.Calculator

  def get_fibonacci(calculator_pid, number) do
    GenServer.call(calculator_pid, {:get_fibonacci, number})
  end

  def new_calculator do
    Fibonacci.Server.start_link()
  end

  def history(calculator_pid) do
    GenServer.call(calculator_pid, {:get_history})
  end

  def stats(calculator_pid) do
    GenServer.call(calculator_pid, {:get_stats})
  end

end
