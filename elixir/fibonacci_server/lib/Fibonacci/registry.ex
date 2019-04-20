defmodule Fibonacci.Registry do
  use GenServer

  def init(table_name) do
    names = :ets.new(table_name, [:set, :named_table, read_concurreny: true])
    refs = %{}
    {:ok, {names, refs}}
  end

  # def call_fib(foo) do
  #   case lookup(numbers, number) do
  #     {:ok, _pid} -> {:noreply, {numbers, refs}}
  #     :error ->
  #       # call_fibonaci
  #       :ets.insert(:table_name, {number, number})
  #   end
  #   # add entry to struct / ets
  #   # calculate foo
  # end

  # server == tablename
  def lookup(table, number) do
    case :ets.lookup(table, number) do
      # [^name, pid] -> {:ok, pid}
      [{^number, value}] -> value
      [] -> :error
    end
  end

  # def handle_cast({: get_fibonacci, number}, {numbers, refs}) do
  #   case lookup(numbers, number) do
  #     {:ok, _pid} -> {:noreply, {numbers, refs}}
  #     :error ->
  #       # call_fibonaci
  #       :ets.insert(:table_name, {number, number})
  #   end
  # end


end
