defmodule Aoc.Util do
  def parse_lines(input, split \\ "\n") do
    input
    |> String.split(split)
    |> Enum.map(&String.trim/1)
    |> Enum.filter(&(&1 != ""))
  end
end
