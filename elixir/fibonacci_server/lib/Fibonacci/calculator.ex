defmodule Fibonacci.Calculator do


  def calculate(0), do: 0
  def calculate(1), do: 1
  def calculate(n), do: calculate(n-1) + calculate(n - 2)

  # defp calculate(num1, num2) do
  #   # nextnum
  #   num1 + num2
  #   calculate()
  # end

  # tail cal optimized




end
