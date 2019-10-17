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

  def reverseMatrix(matrix) do
    sep_head_and_tail(matrix)
    # Enum.map(hd(m), fn x -> get_heads() end)
  end

  def get_heads(m) do
    get_heads(m, 0)
  end
  def get_heads(matrix, count) do
    summing = true
    Enum.reduce(matrix, 0, fn
      x, sum when summing ->
        h = hd(x)
        if h != 0 do
          h + sum
        else
            summing = false
            sum
        end
      _, sum -> sum
    end)
  end
  defp get_tails(matrix) do
    Enum.map(matrix, fn x -> tl(x) end)
  end
  defp sep_head_and_tail(matrix) do
    heads = get_heads(matrix)
    tails = get_tails(matrix)
  end

end
