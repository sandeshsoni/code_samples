defmodule FibonacciServer do

  defdelegate calculate(num), to: Fibonacci.Calculator


  # TODO
  # defdelegate calculate(list)

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
