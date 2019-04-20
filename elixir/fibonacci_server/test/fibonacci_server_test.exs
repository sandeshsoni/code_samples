defmodule FibonacciServerTest do
  use ExUnit.Case
  doctest FibonacciServer

  test "greets the world" do
    assert FibonacciServer.hello() == :world
  end

  test "get correct fibonacci for single element" do
    assert FibonacciServer.calculate(100) == 354224848179261915075
    assert FibonacciServer.calculate(40) == 102334155
  end

  test "get correct fibonacci for a list" do
    assert FibonacciServer.calculate([ 100, 40 ]) == [
      354224848179261915075,
      102334155
    ]
  end

end
