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

  def reverseMatrix([[]]) do
    0
  end
  def reverseMatrix(matrix) do
    reverseMatrix(matrix, 0)
  end
  def reverseMatrix(matrix, sum) do
    heads = Enum.map(matrix, fn [h | _t] -> h end)
    tails = Enum.map(matrix, fn [_ | t] -> t end)
    reverseMatrix(tails, sum + untilZero(heads))
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

end
