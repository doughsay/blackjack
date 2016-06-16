defmodule Blackjack.Rules.Deal do
  alias Blackjack.Game

  def match(%Game{phase: :deal}, _), do: {:match, []}
  def match(_, _), do: :no_match

  def apply(game, _) do
    game
    |> Game.deal
  end
end
