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
    |> String.graphemes()
    |> Enum.sort()
    |> Enum.chunk_by(& &1)
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

  def arrayMaximalAdjacentDifference(inputArray) do
    inputArray
    |> Enum.zip(tl(inputArray))
    |> Enum.reduce(0, fn {first, second}, max ->
      if abs(first - second) > max do
        abs(first - second)
      else
        max
      end
    end)
  end

  def isIPv4Address(inputString) do
    nums =
      inputString
      |> String.split(".")

    if length(nums) != 4 do
      false
    else
      Enum.all?(nums, fn x ->
        case Integer.parse(x) do
          {num, ""} -> 255 >= num and num >= 0
          {_, _} -> false
          :error -> false
        end
      end)
    end
  end

  def avoidObstacles(inputArray) do
    avoidObstacles(inputArray, 1)
  end

  def avoidObstacles(nums, count) do
    case Enum.any?(nums, &(rem(&1, count) == 0)) do
      true -> avoidObstacles(nums, count + 1)
      _ -> count
    end
  end

  def boxBlur(image) do
    Enum.map(0..(length(image) - 3), fn x ->
      row = Enum.at(image, x)

      Enum.map(0..(length(row) - 3), fn y ->
        sumMatix(image, x, y)
      end)
    end)
  end

  defp sumMatix(matrix, x, y) do
    [[0, 0], [1, 0], [2, 0], [0, 1], [1, 1], [2, 1], [0, 2], [1, 2], [2, 2]]
    |> Enum.reduce(0, fn [dx, dy], num ->
      matrix
      |> Enum.at(dx + x)
      |> Enum.at(dy + y)
      |> (&(&1 + num)).()
    end)
    |> (&div(&1, 9)).()
  end

  # def boxBlur(image) do
  #   Enum.chunk_every(image, 3, 1, :discard)
  #   |> Enum.map(&_boxBlur(&1))
  # end

  # def _boxBlur(image) do
  #   Enum.map(image, &Enum.chunk_every(&1, 3, 1, :discard))
  #   |> Enum.map(fn y -> Enum.map(y, fn x -> Enum.sum(x) end) end)
  #   |> Enum.zip
  #   |> Enum.map(fn x -> div(Tuple.to_list(x) |> Enum.sum, 9) end)
  # end
  def minesweeper(matrix) do
    Enum.map(
      0..(length(matrix) - 1),
      fn x ->
        row = Enum.at(matrix, x)

        Enum.map(
          0..(length(row) - 1),
          fn y -> minesweeper(matrix, x, y) end
        )
      end
    )
  end

  def minesweeper(matrix, x, y) do
    [[-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]]
    |> Enum.reduce(0, fn [dx, dy], sum ->
      row = Enum.at(matrix, x + dx)

      if dx + x < 0 or dy + y < 0 or row == nil do
        sum
      else
        case Enum.at(row, y + dy) do
          true -> sum + 1
          _ -> sum
        end
      end
    end)
  end

  #   def minesweeper(m) do
  #     empty = List.duplicate(false, length(hd(m)) + 2)
  #     padded = [empty] ++ Enum.map(m, fn x -> [false] ++ x ++ [false] end) ++ [empty]
  #     |> Enum.map(fn x -> Enum.chunk_every(x, 3, 1, :discard) end)
  #     |> Enum.chunk_every(3, 1, :discard)
  #     |> Enum.map(fn x -> Enum.zip(x) end)
  #     |> Enum.map(fn x -> Enum.map(x, fn y -> mine_count(y) end) end)
  #  end

  #  def mine_count({[a, b, c], [d, e, f], [g, h, i]}) do Enum.count([a, b, c, d, f, g, h, i], &(&1)) end

  def arrayReplace(inputArray, elemToReplace, substitutionElem) do
    Enum.map(inputArray, fn
      x when x == elemToReplace -> substitutionElem
      x -> x
    end)
  end

  # def arrayReplace(inputArray, elemToReplace, substitutionElem) do
  #   Enum.map(inputArray, fn i ->
  #       case i do
  #           ^elemToReplace -> substitutionElem
  #           _ -> i
  #       end
  #   end)
  # end
  def evenDigitsOnly(n) do
    n
    |> Integer.digits()
    |> Enum.all?(&(rem(&1, 2) == 0))
  end

  def variableName(name) do
    String.match?(name, ~r/^[_a-zA-Z]+[_a-zA-Z0-9]*$/)
  end

  def alphabeticShift(inputString) do
    alph = "abcdefghijklmnopqrstuvwxyz" |> String.split("", trim: true)
    alph = Enum.zip(alph, tl(alph) ++ [hd(alph)])

    inputString
    |> String.split("", trim: true)
    |> Enum.map(fn letter ->
      {_, x} = Enum.find(alph, fn {x, _} -> x == letter end)
      x
    end)
    |> Enum.join()
  end

  # def alphabeticShift(s), do: s
  #   |> String.to_charlist
  #   |> Enum.map(&(&1+1))
  #   |> List.to_string
  #   |> String.replace("{","a")
  def chessBoardCellColor(cell1, cell2) do
    [cell1, cell2]
    |> Enum.map(fn pos ->
      pos
      |> String.to_charlist()
      |> Enum.sum()
      |> (&rem(&1, 2)).()
    end)
    |> Enum.reduce(fn x, y -> x == y end)
  end

  # def chessBoardCellColor(<<a,b>>, <<c,d>>), do: rem((a+b)-(c+d), 2) == 0
  def circleOfNumbers(n, firstNumber) do
    n
    |> div(2)
    |> (&(&1 + firstNumber)).()
    |> rem(n)
  end

  def depositProfit(deposit, _rate, threshold) when deposit >= threshold, do: 0
  def depositProfit(deposit, _rate, threshold, year) when deposit >= threshold, do: year
  def depositProfit(deposit, rate, threshold), do: depositProfit(deposit, rate, threshold, 0)

  def depositProfit(deposit, rate, threshold, year) do
    depositProfit(deposit * rate * 0.01 + deposit, rate, threshold, year + 1)
  end

  def absoluteValuesSumMinimization(a) do
    {_sum, number} =
      Enum.reduce(a, {nil, nil}, fn num, {prevSum, prevNum} ->
        sum =
          a
          |> Enum.map(&abs(&1 - num))
          |> Enum.sum()

        if sum > prevSum do
          {prevSum, prevNum}
        else
          {sum, num}
        end
      end)

    number
  end

  # def absoluteValuesSumMinimization(a), do: Enum.min_by(a, fn x -> a |> Enum.map(&(abs(&1-x))) |> Enum.sum end)

  # ["aba", "bbb", "bab"] -> false
  # ["zzzzab", "zzzzbb", "zzzzaa"] -> true
  def stringsRearrangement(input) do
    input
    |> permutate()
    |> Enum.map(fn str ->
      str
      |> Enum.map(&String.split(&1, "", trim: true))
      |> (&Enum.zip(&1, tl(&1))).()
      |> compareWords()
    end)
    |> Enum.any?(fn x -> x |> Enum.all?(&(&1 == 1)) == true end)
  end

  def compareWords(t) do
    t
    |> IO.inspect()
    |> Enum.map(fn {l, r} -> compareWords(l, r, 0) end)

    # compareWords(l, r, 0)
  end

  def compareWords([h1 | t1], [h2 | t2], misses) do
    misses = if h1 == h2, do: misses, else: misses + 1
    compareWords(t1, t2, misses)
  end

  def compareWords([], [], misses), do: misses

  def permutate([]) do
    [[]]
  end

  def permutate(list) do
    for h <- list, t <- permutate(list -- [h]), do: [h | t]
  end

  def extractEachKth(inputArray, k) do
    extractEachKth(inputArray, k, 1, [])
  end

  def extractEachKth([h | t], k, i, res) do
    res = if rem(i, k) == 0, do: res, else: [h | res]
    extractEachKth(t, k, i + 1, res)
  end

  def extractEachKth([], k, i, res) do
    res |> Enum.reverse()
  end

  # def extractEachKth(a, k), do: Enum.drop_every(["" | a], k)

  def firstDigit(inputString) do
    inputString
    |> String.split("", trim: true)
    |> Enum.find(fn str ->
      case Integer.parse(str) do
        {_, ""} -> true
        _ -> false
      end
    end)
  end

  def differentSymbolsNaive(s) do
    s |> String.split("", trim: true) |> Enum.uniq() |> length()
  end
  # def differentSymbolsNaive(s), do: s |> String.graphemes |> Enum.uniq |> length

  def arrayMaxConsecutiveSum(inputArray, k) do
    inputArray
    |> Enum.chunk_every(k, 1)
    |> IO.inspect()
    |> Enum.map(&Enum.sum(&1))
    |> Enum.max()
  end

  # def arrayMaxConsecutiveSum(inputArray, k) do
  #   inputArray
  #   |> Stream.drop(k - 1)
  #   |> Stream.zip([0|inputArray])
  #   |> Stream.scan(
  #     inputArray |> Stream.take(k - 1) |> Enum.sum(),
  #     fn {next_v, prev_v}, prev_sum -> prev_sum + next_v - prev_v end
  #   )
  #   |> Enum.max()
  # end

  def growingPlant(upSpeed, downSpeed, desiredHeight), do: growingPlant(upSpeed, downSpeed, desiredHeight, 0)

  def growingPlant(upSpeed, downSpeed, desiredHeight, days) when (upSpeed - downSpeed) * days + upSpeed >= desiredHeight, do: days + 1
  def growingPlant(upSpeed, downSpeed, desiredHeight, days), do: growingPlant(upSpeed, downSpeed, desiredHeight, days + 1)
  # def growingPlant(upSpeed, _, desiredHeight) when upSpeed >= desiredHeight, do: 1
  # def growingPlant(upSpeed, downSpeed, desiredHeight) do
  #     1 + growingPlant(upSpeed, downSpeed, desiredHeight - upSpeed + downSpeed)
  # end

  def knapsackLight(value1, weight1, value2, weight2, maxW) do
    cond do
      weight1 + weight2 <= maxW -> value1 + value2
      max(weight1, weight2) <= maxW -> max(value1, value2)
      weight1 <= maxW -> value1
      weight2 <= maxW -> value2
      true -> 0
    end
  end

  # def longestDigitsPrefix(inputString) do
  #   case Integer.parse(inputString) do
  #     {num, _} -> Integer.to_string(num)
  #     :error -> ""
  #   end
  # end
  def longestDigitsPrefix(inputString) do
    case Regex.run(~r/^\d+/, inputString) do
      [num] -> num
      nil -> ""
    end
  end
  # def longestDigitsPrefix(s), do: s |> Regex.run(~r/^\d*/, s) |> hd()

  def digitDegree(n) do
    n = Integer.digits(n)
    case length(n) do
      1 -> 0
      _ -> 1 + digitDegree(Enum.sum(n))
    end
  end

  def bishopAndPawn(<<b1, b2>>, <<p1, p2>>) do
    abs(b1 - p1) == abs(b2 - p2)
  end

  def isBeautifulString(inputString) do
    inputString = inputString
    |> String.graphemes()

    97..122
    |> Enum.map(&Enum.count(inputString, fn letter -> letter == <<&1>> end))
    |> (&Enum.zip(&1, tl(&1))).()
    |> Enum.all?(fn {a, b} -> a >= b end)
  end
  # def isBeautifulString(s) do
  #   letter_counts = for n <- ?z..?a, do: Enum.count(to_charlist(s), &(&1==n))
  #   letter_counts == Enum.sort(letter_counts)
  # end

  def findEmailDomain(address) do
    address
    |> String.split("@", trim: true)
    |> List.last()
  end

  def time_to_integer(time) do
    Time.diff(time, ~T[00:00:00])
  end

  def compare_time(from, to) do
    # [from, to, now] = [from, to, Time.utc_now()] |> Enum.map(&time_to_integer/1)
    with now  <- time_to_integer(Time.utc_now()),
         from <- time_to_integer(from),
         to   <- time_to_integer(to) do
      case from > to do
        false -> now >= from and to >= now
        true  -> to >= now or now >= from
      end
    else
      _ -> {:error, :wrong_time_format}
    end
  end

  def buildPalindrome(st), do: buildPalindrome(st, 0)
  def buildPalindrome(st, i) when i <= 20 do
    with tail <- st |> String.slice(0, i) |> String.reverse(),
         word <- st <> tail,
         true <- is_palindrome?(word) do
      word
    else
      _ -> buildPalindrome(st, i + 1)
    end
  end
  # def buildPalindrome(s), do: build(s, s, "")
  # def build(a, <<h::binary-size(1), t::binary>>, c) do
  #     if palindrome?(a <> c), do: a <> c, else: build(a, t, h <> c)
  # end

  def is_palindrome?(w), do: w == String.reverse(w)

  def electionsWinners(votes, 0) do
    if votes |> Enum.filter(& &1 == Enum.max(votes)) |> length() == 1, do: 1, else: 0
  end
  def electionsWinners(votes, k) do
    max = Enum.max(votes)
    votes
    |> Enum.filter(& &1 + k > max)
    |> length()
  end

  def isMAC48Address(inputString) do
    with [_, _, _, _, _, _] = str <- String.split(inputString, "-"),
         true <- Enum.all?(str, fn s -> s |> String.to_integer(16) |> (& &1 >= 0 and 255 >= &1).() end) do
        true
      else
        _ -> false
    end
  end

  def isDigit(symbol) do
    case Integer.parse(symbol) do
      :error -> false
      _ -> true
    end
  end

  # def isDigit(<<c>>), do: c in ?0..?9

  def lineEncoding(s) do
    s
    |> String.graphemes()
    |> Enum.chunk_by(& &1)
    |> Enum.map(fn
      [l]           -> l
      [l | _] = arr -> "#{length(arr)}#{l}"
     end)
    |> Enum.join("")
  end

  def chessKnight(<<h, v>>) do
    atom_map = {:a, :b, :c, :d, :d, :c, :b, :a}
    knight_map = %{
      c: %{a: 4, b: 6, c: 8, d: 8},
      d: %{a: 4, b: 6, c: 8, d: 8},
      b: %{a: 3, b: 4, c: 6, d: 6},
      a: %{a: 2, b: 3, c: 4, d: 4},
    }
    knight_map[elem(atom_map, h - 97)][elem(atom_map, v - 49)]
  end
end
