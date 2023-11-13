defmodule Aoc.Runner do
  defmacro __using__(_) do
    quote do
      def run() do
        run_part1() |> IO.inspect(label: "Part 1")
        run_part2() |> IO.inspect(label: "Part 2")
        :ok
      end

      def run_part1() do
        part1(get_input(1))
      end

      def run_part2() do
        part2(get_input(2))
      end

      defp get_input(part) do
        module_name = to_string(__MODULE__)
        [year, day] = parse_module_name(module_name)
        input_path = "/priv/inputs/#{year}/day#{day}-#{part}.txt"

        if !File.exists?(File.cwd!() <> input_path) do
          nil
        else
          File.read!(File.cwd!() <> input_path)
        end
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
