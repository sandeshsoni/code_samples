defmodule Fibonacci.Registry do
  use GenServer

  # Agent?

  def init(_) do
    # names = :ets.new(:table, [:set, :named_table, read_concurreny: true])
    # refs = %{}
    {:ok, %{}}
  end

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
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

  def lookup(table, number) do
    case :ets.lookup(table, number) do
      # [^name, pid] -> {:ok, pid}
      [{^number, value}] -> value
      [] -> :error
    end
  end

  def handle_cast({get_fibonacci, number}, {numbers, refs}) do
    case lookup(numbers, number) do
      {:ok, _pid} -> {:noreply, {numbers, refs}}
      :error ->
        # call_fibonaci
        :ets.insert(:table_name, {number, number})
    end
  end


end
