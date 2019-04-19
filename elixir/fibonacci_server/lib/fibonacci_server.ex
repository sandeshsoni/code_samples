defmodule FibonacciServer do

  defdelegate calculate(num), to: Fibonacci.Calculator


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
