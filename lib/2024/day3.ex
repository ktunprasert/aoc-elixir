defmodule Aoc.Y2024.D3 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    solve(input, :part1)
  end

  def part2(input) do
    solve(input, :part2)
  end

  def solve(input, part) do
    case part do
      :part1 ->
        ~r/mul\((\d{1,3}),(\d{1,3})\)/
        |> Regex.scan(input)
        |> Enum.map(&tl/1)
        |> Enum.map(fn lst -> lst |> Enum.map(&String.to_integer/1) |> Enum.product() end)
        |> Enum.sum()

      :part2 ->
        ~r/(?:mul\((\d{1,3}),(\d{1,3})\))|(?:do(?:n't)?\(\))/
        |> Regex.scan(input)
        |> find_usable()
        |> Enum.map(&tl/1)
        |> Enum.map(fn lst -> lst |> Enum.map(&String.to_integer/1) |> Enum.product() end)
        |> Enum.sum()
    end
  end

  def find_usable(lst), do: find_usable(lst, [])
  def find_usable([], acc), do: acc

  def find_usable([["do()"] | rest], acc) do
    find_usable(rest, acc)
  end

  def find_usable([["don't()"] | rest], acc) do
    Enum.drop_while(rest, &(&1 != ["do()"]))
    |> find_usable(acc)
  end

  def find_usable([a | rest], acc) do
    find_usable(rest, [a | acc])
  end

  def helper(input) do
    input
  end
end
