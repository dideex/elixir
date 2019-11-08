defmodule Backend.My do
  def adjacentElementsProduct(inputArray) do
    inputArray
    |> mulList()
    |> Enum.max()
  end

  defp mulList([_]) do
    []
  end

  defp mulList([first | rest]) do
    [second | _] = rest
    [first * second | mulList(rest)]
  end

  def almostIncreasingSequence(sequence) do
    case finder(sequence, 0) do
      [] ->
        true

      index ->
        IO.puts(index)

        finder(List.delete_at(sequence, index + 1), 0) == [] or
          finder(List.delete_at(sequence, index), 0) == []
    end
  end

  defp finder([h1 | [h | _]], index) when h1 >= h, do: index
  defp finder([_h | t], index), do: finder(t, index + 1)
  defp finder([], _), do: []

  def matrixElementsSum(matrix) do
    IO.inspect(matrix)
  end

  def matrixElementsSum(matrix) do
    matrixElementsSum(matrix, 0)
  end

  def matrixElementsSum(matrix, sum) do
    case length(hd(matrix)) do
      0 ->
        sum

      _ ->
        heads = Enum.map(matrix, fn [h | _t] -> h end)

        matrix
        |> Enum.map(fn [_ | t] -> t end)
        |> matrixElementsSum(sum + untilZero(heads))
    end
  end

  def untilZero([h | t]) when h !== 0 do
    h + untilZero(t)
  end

  def untilZero([h | _t]) do
    h
  end

  def untilZero([]) do
    0
  end

  def allLongestStrings(inputArray) do
    inputArray
    |> Enum.reduce([""], fn str, [h | _] = acc ->
      cond do
        String.length(str) > String.length(h) -> [str]
        String.length(str) === String.length(h) -> [str | acc]
        true -> acc
      end
    end)
    |> Enum.reverse()
  end

  def allLongestStringsSolved(n) do
    grouped = Enum.group_by(n, &String.length/1)
    Map.fetch!(grouped, Enum.max(Map.keys(grouped)))
  end

  def commonCharacterCount(s1, s2) do
    a1 = String.split(s1, "", trim: true)
    a2 = String.split(s2, "", trim: true)
    commonCharacterCount(a1, a2, 0)
  end

  def commonCharacterCount([h | t], a2, count) do
    cond do
      Enum.member?(a2, h) ->
        commonCharacterCount(t, List.delete(a2, h), count + 1)

      true ->
        commonCharacterCount(t, a2, count)
    end
  end

  def commonCharacterCount([], _, count) do
    count
  end

  # def commonCharacterCount(s1, s2) do
  #   left = String.to_charlist(s1)
  #   right = String.to_charlist(s2)
  #   diff = left -- right
  #   length(left -- diff)
  # end
  def isLucky(n) do
    list = Integer.digits(n)
    middle = div(length(list), 2)

    list
    |> Enum.slice(0, middle)
    |> Enum.zip(Enum.slice(list, middle, length(list)))
    |> Enum.reduce({0, 0}, fn {a1, a2}, {n1, n2} -> {a1 + n1, a2 + n2} end)
    |> (fn {l, r} -> l == r end).()
  end

  #   def isLucky(n) do
  #     nums = Integer.digits(n)

  #     len =
  #       (length(nums) / 2)
  #       |> round

  #     [l1, l2] = Enum.chunk(nums, len)

  #     Enum.sum(l1) === Enum.sum(l2)
  # end
  def sortByHeight(a) do
    noTrees =
      a
      |> Enum.filter(fn x -> x != -1 end)
      |> Enum.sort(&(&1 <= &2))

    sort_with_trees(a, noTrees)
  end

  def sort_with_trees([num | rest], [h | t] = sorted) do
    case num == -1 do
      true -> [num | sort_with_trees(rest, sorted)]
      false -> [h | sort_with_trees(rest, t)]
    end
  end

  def sort_with_trees(a, []) do
    a
  end

  def sort_with_trees([], _) do
    []
  end

  def reverseInParentheses(inputString) do
    s = Regex.replace(~r/\(([\w]*)\)/, inputString, fn _, x -> String.reverse(x) end)

    if Regex.match?(~r/\(/, s) do
      reverseInParentheses(s)
    else
      s
    end
  end

  def alternatingSums(a) do
    alternatingSums(a, [0, 0], 0)
  end

  def alternatingSums([num | rest], [t1, t2], index) do
    if rem(index, 2) == 0 do
      alternatingSums(rest, [t1 + num, t2], index + 1)
    else
      alternatingSums(rest, [t1, t2 + num], index + 1)
    end
  end

  def alternatingSums([], res, _) do
    res
  end

  # def alternatingSums(a) do
  #   pare = Enum.drop_every(a,2)
  #   [Enum.sum(a -- pare),Enum.sum(pare)]
  # end

  def addBorder(picture) do
    picture = Enum.map(picture, fn x -> "*#{x}*" end)
    n = String.length(hd(picture))
    [String.duplicate("*", n)] ++ picture ++ [String.duplicate("*", n)]
  end

  def areSimilar(a, b) do
    areSimilar(a, b, 0)
  end

  def areSimilar([ah | at], [bh | bt], count) do
    cond do
      ah == bh -> areSimilar(at, bt, count)
      ah != bh && length(at) == 0 -> 2
      ah != bh -> areSimilar(at, bt, count + 1, [ah, bh])
      true -> 2
    end
  end

  def areSimilar([ah | at] = a, [bh | bt] = b, count, [sa, sb] = s) do
    cond do
      ah == bh -> areSimilar(at, bt, count, s)
      bh == sa && ah == sb -> areSimilar(at, bt, count)
      true -> 2
    end
  end

  def areSimilar([], _, count) do
    count
  end

  def areSimilar([], _, count, _) do
    count
  end

  #   def areSimilar(a, b) do
  #     diffs = Enum.zip(a, b)
  #     |> Enum.filter(fn {x, y} -> x != y end)

  #     Enum.empty?(diffs) or match?([{x, y}, {y, x}], diffs)
  # end
  def arrayChange([h | t] = inputArray) do
    t
    |> Enum.reduce({0, h}, fn cur, {count, prev} ->
      if cur > prev do
        {count, cur}
      else
        diff = prev - cur + 1
        {count + diff, cur + diff}
      end
    end)
    |> elem(0)
  end
  def palindromeRearranging(inputString) do
    inputString
    |> String.graphemes
    |> Enum.sort
    |> Enum.chunk_by(&(&1))
    |> Enum.filter(fn x -> rem(length(x), 2) == 1 end)
    |> length <= 1
  end
  def areEquallyStrong(yourLeft, yourRight, friendsLeft, friendsRight) do
    cond do
      yourLeft == friendsLeft and yourRight == friendsRight -> true
      yourLeft == friendsRight and yourRight == friendsLeft -> true
      true -> false
    end
  end
  # def areEquallyStrong(l1, r1, l2, r2) do
  #   Enum.min_max([l1, r1]) == Enum.min_max([l2, r2])
  # end
end
