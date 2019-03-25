defmodule Ttt do

  def play_terminal do
    IO.puts("""
    You have signed up to play
    The Reigning
    Defending
    Undisputed
    Tic Tac Toe champion of this computer.
    COMPUTER!!!!!!!!!!!!!!!!!!!
    💪💻🤳

    Let's begin
    """)

    Ttt.Terminal.pick_team()
  end
end
