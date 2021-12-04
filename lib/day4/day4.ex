defmodule V2021.Day4 do
  @input_file_part1 "lib/day4/input.txt"
  @input_file_part2 "lib/day4/input.txt"

  def solution_part1() do
    @input_file_part1
    |> parse_input()
    |> build_game()
    |> play_game()
    |> IO.puts()
  end

  def solution_part2() do
    @input_file_part2
    |> parse_input()
    |> build_game()
    |> play_game2()
    |> IO.puts()
  end

  defp parse_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
  end

  defp build_game([numbers | [ "" | input]]) do
    {
      build_boards([[]], input),
      numbers
      |> String.split(",")
      |> Enum.map(&(String.to_integer(&1)))
    }
  end

  defp build_boards([_ | boards], []) do boards end
  defp build_boards([rows | boards], ["" | rest]) do
    [
      [] |
      [
        complete_board(rows) |
        boards
      ]
    ]
    |> build_boards(rest)
  end

  defp build_boards([rows | boards], [board_row | rest]) do
    [
      rows ++ [
        board_row
        |> String.split(" ", trim: true)
        |> Enum.map(&(String.to_integer(&1)))
      ] |
      boards
    ]
    |> build_boards(rest)
  end

  defp complete_board(rows) do
    %{
      rows: rows,
      cols: rows
            |> Enum.zip()
            |> Enum.map(&Tuple.to_list/1)
    }
  end

  defp play_game({boards, [number | rest]}) do
    updated_boards = update_boards(boards, number)
    winners = find_winners(updated_boards)

    if Enum.empty?(winners) do
      play_game({ updated_boards, rest })
    else
      winners
      |> List.first()
      |> board_score()
      |> Kernel.*(number)
    end
  end

  defp update_boards([], _) do [] end
  defp update_boards([%{rows: rows, cols: cols} | boards], number) do
    [
      %{
        rows: Enum.map(rows, &(List.delete(&1, number))),
        cols: Enum.map(cols, &(List.delete(&1, number))),
      } |
      update_boards(boards, number)
    ]
  end

  defp find_winners([]) do [] end
  defp find_winners([%{rows: rows, cols: cols} | rest]) do
    if Enum.any?(rows, &(Enum.empty?(&1)))
       || Enum.any?(cols, &(Enum.empty?(&1))) do
      [%{rows: rows, cols: cols}] ++ find_winners(rest)
    else
      find_winners(rest)
    end
  end

  defp board_score(%{rows: _, cols: cols}) do
    cols
    |> Enum.map(&(Enum.sum(&1)))
    |> Enum.sum()
  end

  defp play_game2({boards, [number | rest]}) do
    updated_boards = update_boards(boards, number)
    winners = find_winners(updated_boards)
    updated_boards = Enum.reduce(winners, updated_boards, &(List.delete(&2, &1)))

    if winners && Enum.empty?(updated_boards) do
      winners
      |> List.first()
      |> board_score()
      |> Kernel.*(number)
    else
      play_game2({ updated_boards, rest })
    end
  end
end