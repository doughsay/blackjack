defmodule Blackjack.Rules.Stand do
  alias Blackjack.Game

  def match(%Game{phase: :play}, %{play: :stand}), do: {:match, []}
  def match(_, _), do: :no_match

  def apply(game, _) do
    game
    |> Game.phase(:dealer_play)
  end
end
