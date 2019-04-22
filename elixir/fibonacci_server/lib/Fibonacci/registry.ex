defmodule Fibonacci.Registry do
  use GenServer

  # Agent?

  def init(_) do
    # names = :ets.new(:table, [:set, :named_table])
    # refs = %{}
    {:ok, Fibonacci.Calculator.new_calculator()}
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

  # def lookup(table, number) do
  #   case :ets.lookup(table, number) do
  #     # [^name, pid] -> {:ok, pid}
  #     [{^number, value}] -> value
  #     [] -> :error
  #   end
  # end

  def handle_call({:get_fibonacci, number}, _from, calculator) do
    answer = Fibonacci.Calculator.calculate(number)
    { :reply, answer, calculator }

      # case lookup(numbers, number) do
      #   {:ok, _pid} -> {:noreply, {numbers, refs}}
    #   :error ->
    #     # call_fibonaci
    #     :ets.insert(:table_name, {number, number})
    # end

  end


end
