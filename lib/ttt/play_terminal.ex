defmodule Ttt.PlayTerminal do
  alias Ttt.{State, Minimax, Outcome}

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

    state = %State{
      board: Enum.to_list(0..8),
      outcome: :ongoing,
      turn: :human
    }

    play(state)
  end

  def play(state) do
    format_board(state) <> "\n"
    |> IO.puts()

    case Outcome.update_game_outcome(state) do
      %State{outcome: :comp_win} ->
        "Computer wins. AGAIN!!!!"

      %State{outcome: :human_win} ->
        "Player wins. THAT'S IMPOSSIBLE. Really, this can never happen"

      %State{outcome: :draw} ->
        "You managed to get a draw. Well played"

      %State{outcome: :ongoing, turn: :human} ->
        get_human_move(state)
        |> play

      %State{outcome: :ongoing, turn: :comp} ->
        comp_spot = Minimax.minimax(state, "x")

        updated_board = Minimax.update_board(state, comp_spot, "x")
        updated_state =
          %{state |
            board: updated_board,
            turn: :human
          }

        IO.puts("Computer plays spot #{comp_spot} \n")
        play(updated_state)
    end
  end

  defp get_human_move(state) do
    human_spot =
      IO.gets("Pick your spot. \n> ")
      |> String.split()
      |> hd()
      |> String.to_integer()

    %{
      state |
        board: Minimax.update_board(state, human_spot, "o"),
        turn: :comp
    }
  end

  defp format_board(state) do
    state.board
    |> Enum.chunk_every(3)
    |> Enum.map(&format_row/1)
    |> Enum.intersperse("--- --- ---")
    |> Enum.join("\n")
  end

  defp format_row(row) do
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
