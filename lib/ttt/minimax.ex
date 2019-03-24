defmodule Ttt.Minimax do
  alias Ttt.{Outcome, State}

  def minimax(state) do
    depth = get_depth(state)
    avail_moves = Outcome.get_avail_moves(state)

    moves_with_index =
      state
      |> ttt(depth)
      |> Enum.zip(avail_moves)

    {_score, index} =
      pick_for_comp_or_human(
        state,
        Enum.max_by(moves_with_index, fn({s, _i}) -> s end),
        Enum.min_by(moves_with_index, fn({s, _i}) -> s end)
      )
    index
  end

  defp ttt(state, depth) do
    case State.update_outcome(state) do
      %State{outcome: :comp_win} ->
        [depth]

      %State{outcome: :player_win} ->
        [-depth]

      %State{outcome: :draw} ->
        [0]

      %State{outcome: :ongoing} ->
        play_move(state)
    end
  end

  defp pick_for_comp_or_human(state, max_func, min_func) do
    case state.turn do
      :comp ->
        max_func
      :player ->
        min_func
    end
  end

  defp play_move(state) do
    depth = get_depth(state)

    state
    |> Outcome.get_avail_moves()
    |> Enum.map(&State.update_board(state, &1))
    |> Enum.map(fn(updated_state) ->
      updated_state
      |> State.update_turn()
      |> ttt(depth)
      |> min_max_move_picker(updated_state)
    end)
  end

  defp min_max_move_picker(list, state) do
    pick_for_comp_or_human(state, Enum.max(list), Enum.min(list))
  end

  defp get_depth(state) do
    state |> Outcome.get_avail_moves() |> length()
  end
end
