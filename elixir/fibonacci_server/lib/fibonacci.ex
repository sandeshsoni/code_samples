defmodule Fibonacci do

  alias Fibonacci.Calculator

  # defdelegate calculate(num), to: Fibonacci.Calculator
  def get_fibonacci(calculator_pid, number) do
    # : Fibonacci.Calculator
    # Fibonacci.Registry.call()
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

  # def calculate(input) do
  #   call_fib input
  # end

  # TODO
  # historification

  # history
  # history_count
  # observor?

  # TODO
  # cache results

  @moduledoc """
  Documentation for FibonacciServer.
  """

  @doc """
  Hello world.

  ## Examples

      iex> FibonacciServer.hello()
      :world

  """
  def hello do
    :world
  end
end
