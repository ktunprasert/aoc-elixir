defmodule Aoc.Y2020.D9 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input, range \\ 25) do
    nums = helper(input)

    preamble(nums, range)
  end

  def part2(input) do
    :ok
  end

  def preamble(nums, range) do
    0..(length(nums) - range - 1)
    |> Stream.map(fn idx ->
      [target | nums] = Enum.slice(nums, idx, range + 1) |> Enum.reverse()

      # Creating a combination stream from two arrays
      Stream.flat_map(nums, fn i -> Stream.map(nums, fn j -> {i, j} end) end)
      |> Enum.reduce_while(
        :not_found,
        fn
          {i, j}, _ when i + j == target ->
            {:halt, :ok}

          _, acc ->
            {:cont, acc}
        end
      )
      |> then(&{&1, target})
    end)
    |> Enum.reduce_while(nil, fn
      {:not_found, n}, _acc -> {:halt, n}
      _, acc -> {:cont, acc}
    end)
  end

  def helper(input) do
    input |> parse_lines() |> Enum.map(&String.to_integer/1)
  end
end
