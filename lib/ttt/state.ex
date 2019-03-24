defmodule Ttt.State do
  @enforce_keys [:board, :outcome, :turn]
  defstruct @enforce_keys
end