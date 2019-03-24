defmodule Ttt.MinimaxTest do
  use ExUnit.Case
  alias Ttt.{Minimax, State}

  # List of board names
  @keys [:board1, :board2, :board3, :board4, :board5, :one_move, :no_moves]

  # List of tic tac toe boards
  @boards [
    [:o, :x, :x, :x, 4, :x, 6, :o, :o],
    [:o, 1, :x, :x, 4, 5, :x, :o, :o],
    [0, :x, 2, :x, :x, :o, :x, :o, :o],
    [0, :o, 2, 3, 4, :o, :x, :x, :o],
    [:x, 1, :o, 3, :o, 5, :x, 7, 8],
    [:o, 1, 2, 3, 4, 5, 6, 7, 8],
    [0, 1, 2, 3, 4, 5, 6, 7, 8]
  ]

  # Creates a list of tuples that are {board_name, state}
  @states for i <- 0..length(@keys) - 1, do: {
    Enum.at(@keys, i),
    %State{
      board: Enum.at(@boards, i),
      outcome: :ongoing,
      turn: :comp,
      player: :o,
      comp: :x,
      available_moves: Enum.filter(Enum.at(@boards, i), &is_integer/1)
    }
  }

  test "Testing get_comp_move returns best move that can be played for team x" do
    states = Enum.into(@states, %{})

    assert Minimax.get_comp_move(states.board1) == 4
    assert Minimax.get_comp_move(states.board2) == 4
    assert Minimax.get_comp_move(states.board3) == 0
    assert Minimax.get_comp_move(states.board4) == 2
    assert Minimax.get_comp_move(states.board5) == 3
    assert Minimax.get_comp_move(states.one_move) == 4
    assert Minimax.get_comp_move(states.no_moves) == 0
  end

  test "Testing get_comp_move returns best move that can be played for team o" do
    updated_states =
      @states
      |> Enum.map(fn({key, state}) -> {key, %{state | player: :x, comp: :o}} end)
      |> Enum.into(%{})

    assert Minimax.get_comp_move(updated_states.board1) == 4
    assert Minimax.get_comp_move(updated_states.board2) == 4
    assert Minimax.get_comp_move(updated_states.board3) == 2
    assert Minimax.get_comp_move(updated_states.board4) == 2
    assert Minimax.get_comp_move(updated_states.board5) == 3
  end
end
