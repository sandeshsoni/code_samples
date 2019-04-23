defmodule FibonacciServerTest do
  use ExUnit.Case
  # doctest FibonacciServer

  # test "greets the world" do
  #   assert FibonacciServer.hello() == :world
  # end

  # test "get correct fibonacci for single element" do
  #   assert FibonacciServer.calculate(100) == 354224848179261915075
  #   assert FibonacciServer.calculate(40) == 102334155
  # end

  # test "get correct fibonacci for a list" do
  #   assert FibonacciServer.calculate([ 100, 40 ]) == [
  #     354224848179261915075,
  #     102334155
  #   ]
  # end

  test "get fibonacci" do
    {:ok, calc_pid} = Fibonacci.new_calculator
    assert Fibonacci.get_fibonacci(calc_pid, 25) == 75025
  end

  test "historification" do
    {:ok, calc_pid} = Fibonacci.new_calculator
    assert Fibonacci.get_fibonacci(calc_pid, 25) == 75025
    assert Fibonacci.get_fibonacci(calc_pid, 100) == 354224848179261915075
    assert Fibonacci.get_fibonacci(calc_pid, 40) == 102334155
    assert Fibonacci.get_fibonacci(calc_pid, 25) == 75025
    assert Fibonacci.history(calc_pid) == [25, 40,  100, 25]
  end

  test "stats" do
    {:ok, calc_pid} = Fibonacci.new_calculator
    assert Fibonacci.get_fibonacci(calc_pid, 25) == 75025
    assert Fibonacci.get_fibonacci(calc_pid, 100) == 354224848179261915075
    assert Fibonacci.get_fibonacci(calc_pid, 40) == 102334155
    assert Fibonacci.get_fibonacci(calc_pid, 25) == 75025
    assert Fibonacci.get_fibonacci(calc_pid, 25) == 75025
    assert Fibonacci.stats(calc_pid) == %{25 => 3, 40 => 1, 100 => 1}
  end

  test "stats with input as list" do
    # do we need to flatten the list? more input

    {:ok, calc_pid} = Fibonacci.new_calculator
    Fibonacci.get_fibonacci(calc_pid, [25, 10])
    Fibonacci.get_fibonacci(calc_pid, 100)
    Fibonacci.get_fibonacci(calc_pid, 40)
    Fibonacci.get_fibonacci(calc_pid, 25)
    assert Fibonacci.stats(calc_pid) == %{25 => 1, 40 => 1, 100 => 1, [25, 10] => 1}
  end

end
