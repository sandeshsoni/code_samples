defmodule Fibonacci.Calculator do


  # def calculate(0), do: 0
  # def calculate(1), do: 1
  # def calculate(n), do: calculate(n-1) + calculate(n - 2)

  # defp calculate(num1, num2) do
  #   # nextnum
  #   num1 + num2
  #   calculate()
  # end

  # tail cal optimized

  # if names are not sure, then use foobar, rename later
  # cache results, map?
  # defmodule Foo do
  # end

  # nums %{ 1: 10 }

  defstruct(
    nums: %{},
    history: []
  )

  # def new_calculator do
  #   # ets or agent?
  #   names = :ets.new(:table, [:set, :public, :named_table])
  #   # %{a: "b", c: "d"}
  #   %Fibonacci.Calculator{}
  # end

  def calculate(list) when is_list(list) do
    Enum.map(list, fn x -> calculate(x) end)
  end

  def calculate(0), do: 0
  def calculate(1), do: 1

  def calculate(n) do
    IO.puts "in cal";
    calculate(n, 1, 0)
  end

  defp calculate(0,_,result), do: result

  defp calculate(n, next, result) do
    calculate(n-1, next + result, next)
  end

  def history(state) do
    # state[:history]
    state.history
  end

  def stats state do
    convert_stats state.history
  end

  defp convert_stats history do
    history
    |> Enum.reduce( %{}, fn x, acc -> Map.update(acc,x,1,&(&1+1)) end)
  end


end
