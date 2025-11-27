defmodule Fibonacci1000DigitsTest do
  use ExUnit.Case, async: true

  test "tail_recursive basic cases" do
    assert Fibonacci1000Digits.tail_recursive(1) == 1
    assert Fibonacci1000Digits.tail_recursive(2) == 7
    assert Fibonacci1000Digits.tail_recursive(3) == 12
  end

  test "tail_recursive 1000 digits" do
    assert Fibonacci1000Digits.tail_recursive(1000) == 4782
  end

  test "recursive small case" do
    assert Fibonacci1000Digits.recursive(3) == 12
  end

  test "modular 1000 digits" do
    assert Fibonacci1000Digits.modular(1000, 5000) == 4782
  end

  test "with_map 1000 digits" do
    assert Fibonacci1000Digits.with_map(1000, 5000) == 4782
  end

  test "with_for 1000 digits" do
    assert Fibonacci1000Digits.with_for(1000, 5000) == 4782
  end

  test "with_stream 1000 digits" do
    assert Fibonacci1000Digits.with_stream(1000) == 4782
  end
end
