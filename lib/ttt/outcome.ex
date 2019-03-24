defmodule Ttt.Outcome do
  @comp "x"
  @human "o"

  def update_game_outcome(state) do
    cond do
      win?(state.board, @comp) ->
        Map.put(state, :outcome, :comp_win)

      win?(state.board, @human) ->
        Map.put(state, :outcome, :human_win)

      get_avail_moves(state) == [] ->
        Map.put(state, :outcome, :draw)

      true ->
        Map.put(state, :outcome, :ongoing)
    end
  end

  defp win?([i0, i1, i2, i3, i4, i5, i6, i7, i8], player) do
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

  defp all_same?(combo, player) do
    Enum.all?(combo, &(&1 == player))
  end

  def get_avail_moves(state), do: Enum.filter(state.board, &is_integer/1)
end
