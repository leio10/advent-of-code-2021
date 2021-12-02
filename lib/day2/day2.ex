defmodule V2021.Day2 do
  @input_file_part1 "lib/day2/input.txt"
  @input_file_part2 "lib/day2/input.txt"

  def solution_part1() do
    @input_file_part1
    |> parse_input()
    |> move([0, 0])
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
  end

  defp move([], [h | [d]]) do h*d end
  defp move([step | rest], position) do
    move(rest, apply_step(String.split(step, " "), position))
  end

  defp apply_step(["down" | [x]], [h | [d]]) do [h, d+String.to_integer(x)] end
  defp apply_step(["up" | [x]], [h | [d]]) do [h, d-String.to_integer(x)] end
  defp apply_step(["forward" | [x]], [h | [d]]) do [h + String.to_integer(x), d] end
end
