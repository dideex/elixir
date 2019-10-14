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
    # sequence
    # |> Enum.zip(tl(sequence))
    # |> tl()
    Enum.reduce(sequence, [], fn _, acc ->
      if hd(acc) > hd(hd(acc)) do
        tl(acc)
      else
        acc
      end
    end)

    # |> (&(length(&1) <= 2)).()

    # 2 5 3 5
    # 1 2 5 3 5

    # |> (&(&1 <= 1)).()
  end
end
