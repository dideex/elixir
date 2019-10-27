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
    a
    |> Enum.chunk_by(fn n -> n == -1 end)
    |> Enum.map(fn n -> Enum.sort(n, &(&1 <= &2)) end)
    |> List.flatten()
  end
end
