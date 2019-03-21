defmodule NumberoTest do
  use ExUnit.Case
  doctest Numbero

  test "greets the world" do
    # assert Numbero.hello() == :world
  end


  test "given sampleset, no 6686787825 must contain motorcycle" do
    assert Enum.member? Numbero.bar(6686787825), 'MOTORTRUCK'
  end

  test "given sampleset, no 2282668687 must contain catamounts" do
    assert Enum.member? Numbero.bar(2282668687), 'CATAMOUNTS'
  end

  # test "complete implement 1" do
  #   assert Number.foo(6686787825) == [
  #     ["motor", "usual"],
  #     ["noun", "struck"],
  #     ["nouns", "truck"],
  #     ["nouns", "usual"],
  #     ["onto", "struck"],
  #     "motortruck"]
  # end

end
