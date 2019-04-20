defmodule FibonacciServer do
  use GenServer

  defdelegate calculate(num), to: Fibonacci.Calculator


  # if names are not sure, then use foobar, rename later
  # cache results, map?
  defmodule Foo do
    defstruct bar_history: []
  end

  def call_fib(foo) do
    # add entry to struct / ets
    calculate foo
  end

  def init(table_name) do
    names = :ets.new(table_name, [:named_table, read_concurreny: true])
    refs = %{}
    {:ok, {names, refs}}
  end

  # server == tablename
  def lookup(server, name) do
    case :ets.lookup(server, name) do
      [^name, pid] -> {:ok, pid}
      [] -> :error
    end
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
