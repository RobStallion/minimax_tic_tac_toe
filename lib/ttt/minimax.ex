defmodule Ttt.Minimax do
  alias Ttt.Outcome

  @comp "x"
  @human "o"

  @moduledoc """
  Minimax algorithm build with elixir to solve tic-tac-toe
  """

  @doc """
  func name
  ## Examples

      iex> Ttt.func_name
      :answer

  """

  def opposing(player, v1, v2), do: if player == @human, do: v1, else: v2
  def opposition(player), do: opposing(player, @comp, @human)

  defp pick_for_comp_or_human(player, max_func, min_func) do
    case player do
      @comp ->
        max_func
      @human ->
        min_func
    end
  end

  def get_depth(board) do
    board
    |> Outcome.get_avail_moves()
    |> length()
  end

  def update_board(board, spot, player) do
    List.update_at(board, spot, fn(_) -> player end)
  end

  def min_max_move_picker(list, player) do
    pick_for_comp_or_human(player, Enum.max(list), Enum.min(list))
  end

  def minimax(board, player) do
    depth = get_depth(board)
    avail_moves = Outcome.get_avail_moves(board)

    moves_with_index =
      board
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

  def ttt(board, player, depth) do
    case Outcome.get_end_state(board) do
      :comp_win -> [depth]
      :human_win -> [-depth]
      :draw -> [0]
      :ongoing -> play_move(board, player)
    end
  end

  def play_move(board, player) do
    opponent = opposition(player)
    depth = get_depth(board)

    board
    |> Outcome.get_avail_moves()
    |> Enum.map(&update_board(board, &1, player))
    |> Enum.map(
      &ttt(&1, opponent, depth)
      |> min_max_move_picker(opponent)
    )
  end
end
