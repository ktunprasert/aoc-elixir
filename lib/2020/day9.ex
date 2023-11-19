defmodule Aoc.Y2020.D9 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input, range \\ 25) do
    nums = helper(input)

    preamble(nums, range)
  end

  def part2(input, range \\ 25) do
    nums = helper(input)

    target = preamble(nums, range)

    slice = find_contiguous(nums, target, 0, 1)

    Enum.min(slice) + Enum.max(slice)
  end

  def find_contiguous(nums, _, i, j) when i > length(nums) or j > length(nums), do: :not_found

  def find_contiguous(nums, target, i, j) do
    slice = Enum.slice(nums, i..j)

    case slice |> Enum.sum() do
      ^target -> slice
      sum when sum > target -> find_contiguous(nums, target, i + 1, i + 2)
      sum when sum < target -> find_contiguous(nums, target, i, j + 1)
    end
  end

  def preamble(nums, range \\ 25) do
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
