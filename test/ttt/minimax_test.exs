defmodule Ttt.MinimaxTest do
  use ExUnit.Case
  alias Ttt.{Minimax, State}

  @boards %{
    no_moves_played: (for x <- 0..8, do: x),
    one_o_move: [:o,1,2,3,4,5,6,7,8],
    board1: [
      :o, :x, :x,
      :x,  4, :x,
       6, :o, :o
    ],
    board2: [
      :o,  1, :x,
      :x,  4,  5,
      :x, :o, :o
    ],
    board3: [
       0 ,"x", 2 ,
      "x","x","o",
      "x","o","o"
    ],
    board4: [
       0 ,"o", 2 ,
       3 , 4 ,"o",
      "x","x","o"
    ],
    board5: [
      "x", 1 ,"o",
       3 ,"o", 5 ,
      "x", 7 , 8
    ]
  }

  setup do
    [
      state: %State{
        board: @boards.board1,
        outcome: :ongoing,
        turn: :player,
        player: :o,
        comp: :x
      }
    ]
  end

  test "minimax on board1", fixture do
    assert Minimax.minimax(fixture.state) == 4
  end

  test "minimax on board1 for comp", fixture do
    state = %{fixture.state | turn: :comp}
    assert Minimax.minimax(state) == 4
  end

  test "minimax on board2" do
    state =
      %State{
        board: @boards.board2,
        outcome: :ongoing,
        turn: :player,
        player: :o,
        comp: :x
      }

    assert Minimax.minimax(state) == 4
  end

  test "minimax on board2 for comp" do
    state =
      %State{
        board: @boards.board2,
        outcome: :ongoing,
        turn: :comp,
        player: :o,
        comp: :x
      }

    assert Minimax.minimax(state) == 4
  end
  #
  # test "minimax on board3", fixture do
  #   x_res = Minimax.minimax(fixture.board3, "x")
  #   o_res = Minimax.minimax(fixture.board3, "o")
  #
  #   assert x_res == 0
  #   assert o_res == 2
  # end
  #
  # test "minimax on board4", fixture do
  #   x_res = Minimax.minimax(fixture.board4, "x")
  #   o_res = Minimax.minimax(fixture.board4, "o")
  #
  #   assert x_res == 2
  #   assert o_res == 2
  # end
  #
  # test "minimax on board5", fixture do
  #   x_res = Minimax.minimax(fixture.board5, "x")
  #   o_res = Minimax.minimax(fixture.board5, "o")
  #
  #   assert x_res == 3
  #   assert o_res == 3
  # end
  #
  # test "minimax on draw", fixture do
  #   x_res = Minimax.minimax(fixture.one_o_move, "x")
  #   assert x_res == 4
  # end
end
