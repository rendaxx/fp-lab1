defmodule Lab1.Application do
  use Application

  def start(_type, _args) do
    SumSquareDifference.demo(100)
    IO.puts("")
    Fibonacci1000Digits.demo(1000)
    :init.stop()
    {:ok, self()}
  end
end
