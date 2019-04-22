defmodule Fibonacci.Server do
  use GenServer

  # Agent?

  defstruct(
    nums: %{},
    history: []
  )

  def init(_) do
    # names = :ets.new(:table, [:set, :named_table])
    # refs = %{}
    :ets.new(:table, [:set, :public, :named_table])
    {:ok, %Fibonacci.Server{} }
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

  # def lookup(number) do
  #   case :ets.lookup(:table, number) do
  #     # [^name, pid] -> {:ok, pid}
  #     [{^number, value}] -> value
  #     [] -> :error
  #   end
  # end

  def handle_call({:get_fibonacci, number}, _from, calculator) do
    # answer = Fibonacci.Calculator.calculate(number)

    answer = case :ets.lookup(:table, number) do
               [{^number, value}] -> value
               [] ->
                 answer = Fibonacci.Calculator.calculate(number)
                 :ets.insert_new(:table, {number, answer})
                 answer
             end

    # add to history

    { :reply, answer, %{ calculator | history: [ number | calculator.history ] } }
  end

  defp add_or_increment number do
  end

  def handle_call({:get_history}, _from, calculator_state) do
    {:reply, Fibonacci.Calculator.history(calculator_state), calculator_state}
  end

  def handle_call({:get_stats}, _from, calculator_state) do
    {:reply, Fibonacci.Calculator.stats(calculator_state), calculator_state}
  end

end
