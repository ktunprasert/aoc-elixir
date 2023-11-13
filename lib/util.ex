defmodule Aoc.Util do
  def parse_lines(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.filter(&(&1 != ""))
  end
end
