defmodule FibonacciServer do

  defdelegate calculate(num), to: Fibonacci.Calculator


  # if names are not sure, then use foobar, rename later
  # cache results, map?
  defmodule Foo do
    defstruct bar_history: []
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
