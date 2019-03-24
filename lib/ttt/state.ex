defmodule Ttt.State do
  @enforce_keys [:board, :comp, :outcome, :player, :turn, :available_moves]
  defstruct @enforce_keys

  def update_state(state, spot) do
    state
    |> update_board(spot)
    |> update_turn()
    |> update_avail_moves()
    |> update_outcome()
  end

  defp update_board(state, spot) do
    %{state | board: List.update_at(state.board, spot, fn(_) -> Map.get(state, state.turn) end)}
  end

  defp update_turn(state) do
    case state.turn do
      :player ->
        %{state | turn: :comp}

      :comp ->
        %{state | turn: :player}
    end
  end

  defp update_avail_moves(state) do
    %{state | available_moves: Enum.filter(state.board, &is_integer/1)}
  end

  defp update_outcome(state) do
    cond do
      win?(state.board, state.comp) ->
        %{state | outcome: :comp_win}

      win?(state.board, state.player) ->
        %{state | outcome: :player_win}

      state.available_moves == [] ->
        %{state | outcome: :draw}

      true ->
        %{state | outcome: :ongoing}
    end
  end

  # ----- WIN HELPERS -----

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
end