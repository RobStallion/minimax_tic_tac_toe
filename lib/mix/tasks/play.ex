defmodule Mix.Tasks.Play do

  def run([arg]) do
    case arg do
      "terminal" ->
        Ttt.play_terminal()

      _ ->
        """
        Please select a valid play option.

        E.g. $ mix play terminal

        Current options are:
          terminal
        """
        |> IO.puts()

    end
  end
end
