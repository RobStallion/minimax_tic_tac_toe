defmodule Ttt.PlayTerminal do
  alias Ttt.{State, Minimax}
  alias IO.ANSI

  def start do
    IO.puts("""
    You have signed up to play
    The Reigning
    Defending
    Undisputed
    Tic Tac Toe champion of this computer.
    COMPUTER!!!!!!!!!!!!!!!!!!!
    💪💻🤳

    \nLet's begin
    """)

    players_team =
      "Start by picking your team. X or O"
      |> pick_team()
      |> String.to_atom()

    comp_team = if players_team == :x, do: :o, else: :x

    init = %State{
      board: Enum.to_list(0..8),
      outcome: :ongoing,
      turn: :player,
      player: players_team,
      comp: comp_team,
      available_moves: Enum.to_list(0..8)
    }

    play(init)
  end

  defp play(state) do
    IO.puts("\n" <> format_board(state) <> "\n")

    case state do
      %State{outcome: :comp_win} ->
        "Computer wins. AGAIN!!!!"

      %State{outcome: :player_win} ->
        "Player wins. THAT'S IMPOSSIBLE. Really, this can never happen"

      %State{outcome: :draw} ->
        "You managed to get a draw. Well played"

      %State{outcome: :ongoing, turn: :player} ->
        player_spot = get_player_move("Pick your spot.")

        state |> State.update_state(player_spot) |> play()

      %State{outcome: :ongoing, turn: :comp} ->
        comp_spot = Minimax.get_comp_move(state)
        IO.puts("Computer plays spot #{comp_spot} \n")

        state |> State.update_state(comp_spot) |> play()
    end
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
      case is_atom(tile) do
        false ->
          " #{tile} "

        true ->
          filled_tile = color_tile(tile)
          " #{filled_tile} "
      end
    end)
    |> Enum.join("|")
  end

  defp color_tile(team) do
    str = team |> Atom.to_string() |> String.upcase()
    case team do
      :x -> ANSI.format([:bright, :blue, str])
      :o -> ANSI.format([:bright, :red, str])
    end
  end

  # ----- CAPTURE PLAYERS INPUTS -----

  defp capture_input(str) do
    IO.gets(str <> " \n> ")
    |> String.split()
    |> hd()
  end

  defp pick_team(str) do
    pick =
      str
      |> capture_input()
      |> String.downcase()

    if pick == "x" || pick == "o" do
     pick
    else
      pick_team("Please pick either X or O (case insensitive)")
    end
  end

  # Need to add logic so human can only pick from avaliable moves
  defp get_player_move(str) do
    str
    |> capture_input()
    |> String.to_integer()
  end
end
