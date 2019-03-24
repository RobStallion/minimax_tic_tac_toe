defmodule Ttt.State do
  @enforce_keys [:board, :comp, :outcome, :player, :turn]
  defstruct @enforce_keys

  alias Ttt.Outcome

  def update_board(state, spot) do
    case state.turn do
      :human ->
        %{state | board: List.update_at(state.board, spot, fn(_) -> state.player end)}

      :comp ->
        %{state | board: List.update_at(state.board, spot, fn(_) -> state.comp end)}
    end
  end

  def update_turn(state) do
    case state.turn do
      :human ->
        %{state | turn: :comp}

      :comp ->
        %{state | turn: :human}
    end
  end

  def update_outcome(state) do
    cond do
      Outcome.win?(state.board, state.comp) ->
        %{state | outcome: :comp_win}

      Outcome.win?(state.board, state.player) ->
        %{state | outcome: :human_win}

      Outcome.get_avail_moves(state) == [] ->
        %{state | outcome: :draw}

      true ->
        Map.put(state, :outcome, :ongoing)
    end
  end
end