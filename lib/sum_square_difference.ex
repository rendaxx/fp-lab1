defmodule SumSquareDifference do
  @default_n 100

  # 0. Решение через формулы

  def formula(n \\ @default_n) do
    sum = div(n * (n + 1), 2)
    sum_of_squares = div(n * (n + 1) * (2 * n + 1), 6)
    sum * sum - sum_of_squares
  end

  # 1. Монолитные реализации
  # 1.1 Хвостовая рекурсия

  def tail_recursive(n \\ @default_n) when n >= 0 do
    do_tail_recursive(1, n, 0, 0)
  end

  defp do_tail_recursive(i, n, sum, sum_sq) when i > n do
    sum * sum - sum_sq
  end

  defp do_tail_recursive(i, n, sum, sum_sq) do
    do_tail_recursive(i + 1, n, sum + i, sum_sq + i * i)
  end

  # 1.2 Обычная рекурсия (не хвостовая)

  def recursive(n \\ @default_n) when n >= 0 do
    {sum, sum_sq} = rec_sums(n)
    sum * sum - sum_sq
  end

  defp rec_sums(0), do: {0, 0}

  defp rec_sums(n) do
    {sum, sum_sq} = rec_sums(n - 1)
    {sum + n, sum_sq + n * n}
  end

  # 2. Модульная реализация: генерация → фильтрация → свёртка

  def modular(n \\ @default_n) when n >= 0 do
    numbers =
      1..n
      |> Enum.to_list()
      |> Enum.filter(&(&1 > 0))

    sum = Enum.reduce(numbers, 0, fn x, acc -> acc + x end)

    sum_of_squares =
      Enum.reduce(numbers, 0, fn x, acc -> acc + x * x end)

    sum * sum - sum_of_squares
  end

  # 3. Генерация последовательности при помощи map

  def with_map(n \\ @default_n) when n >= 0 do
    numbers = Enum.to_list(1..n)
    squares = Enum.map(numbers, &(&1 * &1))

    sum = Enum.sum(numbers)
    sum_of_squares = Enum.sum(squares)

    sum * sum - sum_of_squares
  end

  # 4. Спец. синтаксис циклов — for

  def with_for(n \\ @default_n) when n >= 0 do
    numbers = for x <- 1..n, do: x
    squares = for x <- 1..n, do: x * x

    sum = Enum.sum(numbers)
    sum_of_squares = Enum.sum(squares)

    sum * sum - sum_of_squares
  end

  # 5. Бесконечный поток (Stream.iterate/2)

  def with_stream(n \\ @default_n) when n >= 0 do
    stream = Stream.iterate(1, &(&1 + 1))

    sum =
      stream
      |> Stream.take(n)
      |> Enum.sum()

    sum_of_squares =
      stream
      |> Stream.map(&(&1 * &1))
      |> Stream.take(n)
      |> Enum.sum()

    sum * sum - sum_of_squares
  end

  def demo(n \\ @default_n) do
    IO.puts("SumSquareDifference, n = #{n}")
    IO.puts("0   formula:        #{formula(n)}")
    IO.puts("1.1 tail_recursive: #{tail_recursive(n)}")
    IO.puts("1.2 recursive:      #{recursive(n)}")
    IO.puts("2   modular:        #{modular(n)}")
    IO.puts("3   with_map:       #{with_map(n)}")
    IO.puts("4   with_for:       #{with_for(n)}")
    IO.puts("5   with_stream:    #{with_stream(n)}")
  end
end
