defmodule V2021.Day2 do
  @input_file_part1 "lib/day2/input.txt"
  @input_file_part2 "lib/day2/input.txt"

  def solution_part1() do
    @input_file_part1
    |> parse_input()
    |> IO.puts()
  end

  def solution_part2() do
    @input_file_part2
    |> parse_input()
    |> IO.puts()
  end

  defp parse_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.to_integer(&1))
  end
end
