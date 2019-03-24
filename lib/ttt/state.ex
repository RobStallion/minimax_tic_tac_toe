defmodule Ttt.State do
  @enforce_keys [:board, :outcome, :turn]
  defstruct @enforce_keys

  def update_board(state, spot, player), do:
    %{state | board: List.update_at(state.board, spot, fn(_) -> player end)}

  def update_turn(state, player), do: %{state | turn: player}
  
end