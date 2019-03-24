defmodule Ttt.State do
  @enforce_keys [:board, :comp, :outcome, :player, :turn]
  defstruct @enforce_keys

  alias Ttt.Outcome

  def update_state(state, spot) do
    state
    |> update_board(spot)
    |> update_turn()
    |> update_outcome()
  end

  def update_board(state, spot) do
    %{state | board: List.update_at(state.board, spot, fn(_) -> Map.get(state, state.turn) end)}
  end

  def update_turn(state) do
    case state.turn do
      :player ->
        %{state | turn: :comp}

      :comp ->
        %{state | turn: :player}
    end
  end

  def update_outcome(state) do
    cond do
      Outcome.win?(state.board, state.comp) ->
        %{state | outcome: :comp_win}

      Outcome.win?(state.board, state.player) ->
        %{state | outcome: :player_win}

      Outcome.get_avail_moves(state) == [] ->
        %{state | outcome: :draw}

      true ->
        %{state | outcome: :ongoing}
    end
  end
end