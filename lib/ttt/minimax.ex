defmodule Ttt.Minimax do
  alias Ttt.{Outcome, State}

  @comp "x"
  @human "o"

  def minimax(state, player) do
    depth = get_depth(state)
    avail_moves = Outcome.get_avail_moves(state)

    moves_with_index =
      state
      |> ttt(player, depth)
      |> Enum.zip(avail_moves)

    {_score, index} =
      pick_for_comp_or_human(
        player,
        Enum.max_by(moves_with_index, fn({s, _i}) -> s end),
        Enum.min_by(moves_with_index, fn({s, _i}) -> s end)
      )
    index
  end

  defp ttt(state, player, depth) do
    case Outcome.update_game_outcome(state) do
      %State{outcome: :comp_win} ->
        [depth]

      %State{outcome: :human_win} ->
        [-depth]

      %State{outcome: :draw} ->
        [0]

      %State{outcome: :ongoing} ->
        play_move(state, player)
    end
  end

  defp pick_for_comp_or_human(player, max_func, min_func) do
    case player do
      @comp ->
        max_func
      @human ->
        min_func
    end
  end

  defp play_move(state, player) do
    opponent = opposition(player)
    depth = get_depth(state)

    state
    |> Outcome.get_avail_moves()
    |> Enum.map(&State.update_board(state, &1, player))
    |> Enum.map(fn(updated_state) ->
      ttt(updated_state, opponent, depth) |> min_max_move_picker(opponent)
    end)
  end

  defp min_max_move_picker(list, player) do
    pick_for_comp_or_human(player, Enum.max(list), Enum.min(list))
  end

  defp get_depth(state) do
    state |> Outcome.get_avail_moves() |> length()
  end

  defp opposing(player, v1, v2), do: if player == @human, do: v1, else: v2
  defp opposition(player), do: opposing(player, @comp, @human)
end
