defmodule Aoc.Runner do
  defmacro __using__(_) do
    quote do
      def run() do
        module_name = to_string(__MODULE__)
        [year, day] = parse_module_name(module_name)

        part1_input = "priv/inputs/day#{day}-1.txt"
        part2_input = "priv/inputs/day#{day}-2.txt"

        part1(part1_input)
        part2(part2_input)
      end

      def parse_module_name(module_name) do
        module_name
        |> String.split(".")
        |> Enum.take(-2)
        |> Enum.map(&grab_digits/1)
      end

      def grab_digits(string) do
        case Regex.run(~r/\d+/, string) do
          lst when is_list(lst) -> lst |> List.first()
          nil -> nil
        end
      end
    end
  end
end
