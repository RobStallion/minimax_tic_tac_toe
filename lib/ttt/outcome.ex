defmodule Ttt.Outcome do
  @comp "x"
  @human "o"

  def get_avail_moves(board), do: Enum.filter(board, &is_integer/1)
  
  defp all_same?(combo, player) do
    Enum.all?(combo, &(&1 == player))
  end

  def win?([i0, i1, i2, i3, i4, i5, i6, i7, i8], player) do
    [
      [i0, i1, i2],
      [i3, i4, i5],
      [i6, i7, i8],
      [i0, i3, i6],
      [i1, i4, i7],
      [i2, i5, i8],
      [i0, i4, i8],
      [i2, i4, i6]
    ]
    |> Enum.map(&all_same?(&1, player))
    |> Enum.any?(&(&1 == true))
  end

  def get_end_state(board) do
    cond do
      win?(board, @comp) -> :comp_win
      win?(board, @human) -> :human_win
      get_avail_moves(board) == [] -> :draw
      true -> :ongoing
    end
  end
end
