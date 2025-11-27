defmodule SumSquareDifferenceTest do
  use ExUnit.Case, async: true

  test "formula examples" do
    assert SumSquareDifference.formula(10) == 2640
    assert SumSquareDifference.formula(100) == 25_164_150
  end

  test "tail_recursive examples" do
    assert SumSquareDifference.tail_recursive(10) == 2640
    assert SumSquareDifference.tail_recursive(100) == 25_164_150
  end

  test "recursive small example" do
    assert SumSquareDifference.recursive(10) == 2640
  end

  test "modular example" do
    assert SumSquareDifference.modular(10) == 2640
  end

  test "with_map example" do
    assert SumSquareDifference.with_map(10) == 2640
  end

  test "with_for example" do
    assert SumSquareDifference.with_for(10) == 2640
  end

  test "with_stream example" do
    assert SumSquareDifference.with_stream(10) == 2640
  end
end

