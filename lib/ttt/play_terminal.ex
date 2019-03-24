defmodule Ttt.PlayTerminal do
  alias Ttt.{State, Minimax}

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

    players_team = pick_team("Start by picking your team. X or O")

    init = %State{
      board: Enum.to_list(0..8),
      outcome: :ongoing,
      turn: :human,
      player: players_team,
      comp: get_comp(players_team)
    }

    play(init)
  end

  defp pick_team(str) do
    players_team =
      str
      |> capture_input()
      |> String.downcase()

    if players_team == "x" || players_team == "o" do
      players_team
    else
      pick_team("Please pick either X or O (case insensitive)")
    end
    |> String.to_atom()
  end

  defp play(state) do
    IO.puts("\n" <> format_board(state) <> "\n")

    case State.update_outcome(state) do
      %State{outcome: :comp_win} ->
        "Computer wins. AGAIN!!!!"

      %State{outcome: :human_win} ->
        "Player wins. THAT'S IMPOSSIBLE. Really, this can never happen"

      %State{outcome: :draw} ->
        "You managed to get a draw. Well played"

      %State{outcome: :ongoing, turn: :human} ->
        get_human_move(state) |> play

      %State{outcome: :ongoing, turn: :comp} ->
        comp_spot = Minimax.minimax(state)
        IO.puts("Computer plays spot #{comp_spot} \n")

        updated_state =
          state
          |> State.update_board(comp_spot)
          |> State.update_turn()

        play(updated_state)
    end
  end

  defp get_human_move(state) do
    human_spot =
      capture_input("Pick your spot.")
      |> String.to_integer()

    state
      |> State.update_board(human_spot)
      |> State.update_turn()
  end

  # ---- RENDER BOARD HELPERS -----

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

  defp capture_input(str) do
    IO.gets(str <> " \n> ")
    |> String.split()
    |> hd()
  end

  def get_comp(player) do
    case player do
      :x -> :o
      :o -> :x
    end
  end
end
