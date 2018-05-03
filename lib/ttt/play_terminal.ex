defmodule Ttt.PlayTerminal do
  alias Ttt.{Minimax, Outcome}

  def start do
    IO.puts("""
    You have signed up to play
    \nThe Reigning
    \nDefending
    \nUndisputed
    \nTic Tac Toe champion of this computer.
    \nCOMPUTER!!!!!!!!!!!!!!!!!!!
    \n💪💻🤳

    \nLet's begin
    """)

    play([0,1,2,3,4,5,6,7,8])
  end

  def play(board) do
    format_board(board) <> "\n"
    |> IO.puts()

    case Outcome.get_end_state(board) do
      :comp_win -> "Computer wins. AGAIN!!!!"
      :human_win -> "Player wins"
      :draw -> "This match is a draw."
      :ongoing ->
        case check_whos_go(board) do
          :comp_go ->
            comp_spot = Minimax.minimax(board, "x")
            updated_board = Minimax.update_board(board, comp_spot, "x")

            IO.puts("Computer plays spot #{comp_spot} \n")
            play(updated_board)
          :human_go ->
            get_human_move(board)
        end
    end
  end

  def check_whos_go(board) do
    computer_turns = Enum.count(board, &(&1 == "x"))
    human_turns = Enum.count(board, &(&1 == "o"))

    case computer_turns < human_turns do
      true -> :comp_go
      _    -> :human_go
    end
  end

  def get_human_move(board) do
    human_spot =
      IO.gets("Pick your spot. \n> ")
      |> String.split()
      |> hd()
      |> String.to_integer()

    Minimax.update_board(board, human_spot, "o")
    |> play()
  end

  def format_board(board) do
    board
    |> Enum.chunk_every(3)
    |> Enum.map(&format_row/1)
    |> Enum.intersperse("--- --- ---")
    |> Enum.join("\n")
  end

  def format_row(row) do
    row
    |> Enum.map(fn(tile) ->
      case is_bitstring(tile) do
        false ->
          " #{tile} "
        _     ->
          tile = String.upcase(tile)
          " #{tile} "
      end
    end)
    |> Enum.join("|")
  end
end
