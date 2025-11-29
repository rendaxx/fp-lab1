defmodule Fibonacci1000Digits do
  @target_digits 1000

  defp digit_count(n), do: n |> Integer.digits() |> length()

  # 1. Монолитные реализации
  # 1.1 Хвостовая рекурсия

  def tail_recursive(digits \\ @target_digits)
  def tail_recursive(digits) when digits <= 1, do: 1
  def tail_recursive(digits), do: do_tail_recursive(1, 1, 2, digits)

  defp do_tail_recursive(prev, curr, index, digits) do
    if digit_count(curr) >= digits do
      index
    else
      do_tail_recursive(curr, prev + curr, index + 1, digits)
    end
  end

  # 1.2 Обычная рекурсия (не хвостовая)

  def recursive(digits \\ @target_digits)
  def recursive(digits) when digits <= 1, do: 1
  def recursive(digits), do: rec_non_tail(digits, 1, 1, 2)

  defp rec_non_tail(digits, prev, curr, index) do
    if digit_count(curr) >= digits do
      index
    else
      result = rec_non_tail(digits, curr, prev + curr, index + 1)
      result + 0
    end
  end

  # 2. Модульная реализация: генерация -> фильтрация -> свёртка

  def modular(digits \\ @target_digits, limit \\ 5000) do
    limit
    |> generate_fib()
    |> filter_by_digits(digits)
    |> select_first_index()
  end

  defp generate_fib(limit) when limit >= 2 do
    {_, _, acc} =
      Enum.reduce(2..limit, {0, 1, []}, fn idx, {prev, curr, acc} ->
        next = prev + curr
        {curr, next, [{idx, next} | acc]}
      end)

    Enum.reverse([{1, 1} | acc])
  end

  defp filter_by_digits(pairs, digits) do
    Enum.filter(pairs, fn {_idx, value} -> digit_count(value) >= digits end)
  end

  defp select_first_index(pairs) do
    {idx, _} =
      Enum.reduce_while(pairs, nil, fn {idx, value}, _acc ->
        {:halt, {idx, value}}
      end)

    idx
  end

  # 3. Генерация последовательности при помощи map

  def with_map(digits \\ @target_digits, limit \\ 5000) do
    1..limit
    |> Enum.map(fn idx -> {idx, fib_from_zero(idx)} end)
    |> Enum.find(fn {_idx, value} -> digit_count(value) >= digits end)
    |> case do
      {idx, _} -> idx
      nil -> nil
    end
  end

  defp fib_from_zero(n) do
    {f, _} = fib_pair(n)
    f
  end

  defp fib_pair(0), do: {0, 1}

  defp fib_pair(n) do
    {a, b} = fib_pair(div(n, 2))
    c = a * (2 * b - a)
    d = a * a + b * b

    if rem(n, 2) == 0 do
      {c, d}
    else
      {d, c + d}
    end
  end

  # 4. Спец. синтаксис для циклов (for ... reduce)

  def with_for(digits \\ @target_digits, limit \\ 5000)
  def with_for(digits, _limit) when digits <= 1, do: 1

  def with_for(digits, limit) do
    {_, _, answer} =
      for idx <- 1..limit, reduce: {0, 1, nil} do
        {prev, curr, found} ->
          value = curr

          new_found =
            case found do
              nil ->
                if digit_count(value) >= digits, do: idx, else: nil

              v ->
                v
            end

          {curr, prev + curr, new_found}
      end

    answer
  end

  # 5. Бесконечный поток (Stream)

  def with_stream(digits \\ @target_digits)
  def with_stream(digits) when digits <= 1, do: 1

  def with_stream(digits) do
    fib_stream()
    |> Enum.find(fn {value, _idx} -> digit_count(value) >= digits end)
    |> elem(1)
  end

  def fib_stream do
    Stream.unfold({1, 1, 1}, fn {a, b, index} ->
      {{a, index}, {b, a + b, index + 1}}
    end)
  end

  def demo(target_digits \\ @target_digits) do
    IO.puts("1.1 tail_recursive: #{tail_recursive(target_digits)}")
    IO.puts("1.2 recursive:      #{recursive(target_digits)}")
    IO.puts("2   modular:        #{modular(target_digits)}")
    IO.puts("3   with_map:       #{with_map(target_digits)}")
    IO.puts("4   with_for:       #{with_for(target_digits)}")
    IO.puts("5   with_stream:    #{with_stream(target_digits)}")
  end
end
