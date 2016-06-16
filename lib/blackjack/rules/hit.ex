defmodule Blackjack.Rules.Hit do
  alias Blackjack.Game

  def match(%Game{phase: :play}, %{play: :hit}), do: {:match, []}
  def match(_, _), do: :no_match

  def apply(game, _) do
    game
    |> Game.player_hit
    |> Game.phase(:resolve)
  end
end
