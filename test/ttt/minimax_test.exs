defmodule Ttt.MinimaxTest do
  use ExUnit.Case
  alias Ttt.Minimax

  setup do
    [
      no_moves_played: (for x <- 0..8, do: x),
      board1: [
        "o","x","x",
        "x", 4 ,"x",
         6 ,"o","o"
      ],
      board2: [
        "o", 1 ,"x",
        "x", 4 , 5 ,
        "x","o","o"
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
      ],
      one_o_move: ["o",1,2,3,4,5,6,7,8]
    ]
  end

  test "minimax on board1", fixture do
    x_res = Minimax.minimax(fixture.board1, "x")
    o_res = Minimax.minimax(fixture.board1, "o")

    assert x_res == 4
    assert o_res == 4
  end

  test "minimax on board2", fixture do
    x_res = Minimax.minimax(fixture.board2, "x")
    o_res = Minimax.minimax(fixture.board2, "o")

    assert x_res == 4
    assert o_res == 4
  end

  test "minimax on board3", fixture do
    x_res = Minimax.minimax(fixture.board3, "x")
    o_res = Minimax.minimax(fixture.board3, "o")

    assert x_res == 0
    assert o_res == 2
  end

  test "minimax on board4", fixture do
    x_res = Minimax.minimax(fixture.board4, "x")
    o_res = Minimax.minimax(fixture.board4, "o")

    assert x_res == 2
    assert o_res == 2
  end

  test "minimax on board5", fixture do
    x_res = Minimax.minimax(fixture.board5, "x")
    o_res = Minimax.minimax(fixture.board5, "o")

    assert x_res == 3
    assert o_res == 3
  end

  test "minimax on draw", fixture do
    x_res = Minimax.minimax(fixture.one_o_move, "x")
    assert x_res == 4
  end
end
