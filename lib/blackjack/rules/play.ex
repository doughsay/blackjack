defmodule Blackjack.Rules.Play do
  alias Blackjack.Game

  def match(%Game{phase: :resolve}, _), do: {:match, []}
  def match(_, _), do: :no_match

  def apply(game, _) do
    game
    |> Game.phase(:play)
  end
end
