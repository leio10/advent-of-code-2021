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
    |> move_with_aim([0, 0, 0])
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

  defp move_with_aim([], [h | [d | _]]) do h*d end
  defp move_with_aim([step | rest], position) do
    move_with_aim(rest, apply_step_with_aim(String.split(step, " "), position))
  end

  defp apply_step_with_aim(["down" | [x]], [h | [d | [aim]]]) do [h, d, aim+String.to_integer(x)] end
  defp apply_step_with_aim(["up" | [x]], [h | [d | [aim]]]) do [h, d, aim-String.to_integer(x)] end
  defp apply_step_with_aim(["forward" | [x]], [h | [d | [aim]]]) do [h + String.to_integer(x), d+aim*String.to_integer(x), aim] end
end
