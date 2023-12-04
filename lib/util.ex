defmodule Aoc.Util do
  def parse_lines(input, split \\ "\n") do
    input
    |> String.split(split)
    |> Enum.flat_map(fn line ->
      case String.trim(line) do
        "" -> []
        str -> [str]
      end
    end)
  end
end
