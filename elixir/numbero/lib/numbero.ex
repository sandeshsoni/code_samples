defmodule Numbero do

  # get a list of all dictionary words
  defp all_words do
    File.stream!('assets/dictionary.txt')
    |> Stream.map(&String.trim/1)
    |> Enum.to_list
    {:ok, content} = File.read("assets/dictionary.txt")
    String.split(content, "\n", trim: true)
  end

  def process do
    process(6686787825 )
  end

  def process(input_number) do
    # words = ~w(motor truck star onto nouns struck baz motortruck foo bar)

    combinations = all_words()
    |> Stream.filter(&String.length(&1)>2)
    |> Enum.group_by(&number_cominations(&1,input_number))
    |> Map.delete("nomatch")

    word_pairs_from_list(combinations)
    |> List.flatten
    |> Enum.chunk_every(2)
    |> Enum.concat combinations[10]

  end

  defp word_pairs_from_list vlist do
    for {a,la} <- vlist , {b, lb} <- vlist, (a + b == 0) && a > b,
      do: make_pairs(la, lb)
  end

  defp make_pairs list1, list2 do
    for a <- list1, b <- list2, do: [a, b]
  end

  def word_to_no word do
    word
    |> String.upcase
    |> String.codepoints
    |> Enum.map_join(&(letter_to_number(&1)))
  end

  def letter_to_number letter do
    input_in_string = fn str -> String.contains? str, letter end

    cond do
      input_in_string.("ABC") -> 2
      input_in_string.("DEF") -> 3
      input_in_string.("GHI") -> 4
      input_in_string.("JKL") -> 5
      input_in_string.("MNO") -> 6
      input_in_string.("PQRS") -> 7
      input_in_string.("TUV") -> 8
      input_in_string.("WXYZ") -> 9
      true -> 0
    end

  end

  def number_cominations abcword, input_number do
    word_no = abcword |> word_to_no

    numb = to_string input_number
    cond do
      String.starts_with?(numb, word_no) -> String.length(word_no)
      String.ends_with?(numb, word_no) ->  ((10 - String.length(word_no)) * -1)
      true -> "nomatch"
    end
  end

  ##############################################
  #####
  ##### COMMENTED BELOW OLD LOGIC.
  ##### CORRECT BUT NOT PERFORMANCE RELEVANT
  #####
  ##############################################

  # MapSet.intersection(MapSet.new(list1), MapSet.new(list2)) |> Enum.to_list
  # def intersections list1, list2 do
  #   MapSet.intersection(MapSet.new(list1), MapSet.new(list2))
  #   |> Enum.to_list
  # end

  # part experimental function. not needed
  # def get_all_combinations_from input_number do
  #   map = %{
  #     2 => (List.to_tuple ~w(a b c)),
  #     3 => (List.to_tuple ~w(d e f)),
  #     4 => List.to_tuple ~w(g h i)
  #   }
  #   input_number
  #   |> Integer.digits
  #   |> Enum.map(fn digit -> map[digit] end)
  # end

  # form words of characters
  # 10 - digits.
  # def bar number do
  #   # a <- abc
  #   # b <- pqr
  #   # c <- xyz

  #   mape = %{
  #     2 => 'ABC',
  #     3 => 'DEF',
  #     4 => 'GHI',
  #     5 => 'JKL',
  #     6 => 'MNO',
  #     7 => 'PQRS',
  #     8 => 'TUV',
  #     9 => 'WXYZ'
  #   }

  #   nos = Integer.digits(number)

  #   for n1 <- mape[ Enum.at(nos,0) ],
  #     n2 <- mape[ Enum.at(nos,1) ],
  #     n3 <- mape[ Enum.at(nos,2) ],
  #     n4 <- mape[ Enum.at(nos,3) ],
  #     n5 <- mape[ Enum.at(nos,4) ],
  #     n6 <- mape[ Enum.at(nos,5) ],
  #     n7 <- mape[ Enum.at(nos,6) ],
  #     n8 <- mape[ Enum.at(nos,7) ],
  #     n9 <- mape[ Enum.at(nos,8) ],
  #     n10 <- mape[ Enum.at(nos,9) ],

  #     do: [n1,n2,n3,n4,n5,n6,n7,n8,n9,n10]
  #   |> Enum.map(&to_string/1)
  # end

  # for 3 numbers
  @doc """

  ## examples

  iex> Numbero.baz('abc', 'def', 'ghi')
  ['adg', 'adh', 'adi', 'aeg', 'aeh', 'aei', 'afg', 'afh', 'afi', 'bdg', 'bdh',
   'bdi', 'beg', 'beh', 'bei', 'bfg', 'bfh', 'bfi', 'cdg', 'cdh', 'cdi', 'ceg',
    'ceh', 'cei', 'cfg', 'cfh', 'cfi']

  """
  # all combinations
  # for a <- l1, b <-l1, String.length(a<>b)==10 ,do: %{ a<>b => [a, b] }

  # for a <- l1, b <-l1,
  #   String.length(a<>b)==7 && String.length(a) > 2 && String.length(b) > 2,
  #   do: %{ a<>b => [a, b] }

  # for a <- l1, b <-l1, String.length(a<>b)==10 ,do: a <> b
  def baz list do

    # list = all_words

    # for a <- word1, b <- word2, c <- word3, do: [a,b,c]
    # for a <- list, b <-list, String.length(a <> b)==10 ,do: a <> b
    # for a <- list, b <- list, into: [], do: [a, b]
    # for a <- list, b <- list, into: [], do: [a, b]

    # for a <- list do: a
    # for a <- list do
    #   for b <- list do
    #     if(length(a ++ b) == 10)
    #       do (a ++ b)
    #     end
    #   end
    # end


    # streame = File.stream!('assets/dictionary.txt')
    # |> Stream.map(&String.trim/1)


    # for a <- streame, b <- streame, length(a ++ b)==10, do: a ++ b

  end


end
