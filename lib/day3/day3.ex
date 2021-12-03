defmodule V2021.Day3 do
  @input_file_part1 "lib/day3/input.txt"
  @input_file_part2 "lib/day3/input.txt"

  def solution_part1() do
    @input_file_part1
    |> parse_input()
    |> count_bits()
    |> power_compsumption()
    |> IO.puts()
  end

  def solution_part2() do
    @input_file_part2
    |> parse_input()
    |> life_support_rating()
    |> IO.puts()
  end

  defp parse_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
  end

  defp count_bits([number | rest]) do
    count_bits([number | rest], List.duplicate(0, String.length(number)))
  end

  defp count_bits([], totals) do totals end
  defp count_bits([number | rest], totals) do
    count_bits(rest, sum_number(number, totals))
  end

  defp sum_number("", _) do [] end
  defp sum_number("1" <> number, [total | rest]) do
    [total + 1 | sum_number(number, rest)]
  end
  defp sum_number("0" <> number, [total | rest]) do
    [total - 1 | sum_number(number, rest)]
  end

  defp power_compsumption(totals) do
    gamma(totals, 0) * epsilon(totals, 0)
  end

  defp gamma([], result) do result end
  defp gamma([total | totals], result) when total > 0 do
    gamma(totals, 2 * result + 1)
  end
  defp gamma([total | totals], result) when total < 0 do
    gamma(totals, 2 * result)
  end

  defp epsilon([], result) do result end
  defp epsilon([total | totals], result) when total < 0 do
    epsilon(totals, 2 * result + 1)
  end
  defp epsilon([total | totals], result) when total > 0 do
    epsilon(totals, 2 * result)
  end

  defp life_support_rating(input) do
    [calculate_rating(:oxigen, input),
      calculate_rating(:co2, input)]
    |> Enum.map(&(String.to_integer(&1, 2)))
    |> Enum.product()
  end

  defp calculate_rating(_, []) do "" end
  defp calculate_rating(_, [number]) do number end
  defp calculate_rating(type, numbers) do
    {zeros_list, ones_list} = reduce_first(numbers)
    if (Kernel.length(zeros_list) <= Kernel.length(ones_list)) == (type == :oxigen) do
      "1" <> calculate_rating(type, ones_list)
    else
      "0" <> calculate_rating(type, zeros_list)
    end
  end

  defp reduce_first([]) do {[], []} end
  defp reduce_first(["1" <> number | rest]) do
    {zeros_list, ones_list} = reduce_first(rest)
    {zeros_list, [number | ones_list]}
  end
  defp reduce_first(["0" <> number | rest]) do
    {zeros_list, ones_list} = reduce_first(rest)
    {[number | zeros_list], ones_list}
  end
end
