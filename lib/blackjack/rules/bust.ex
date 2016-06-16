defmodule Blackjack.Rules.Bust do
  alias Blackjack.{Game, Card, Player}

  def match(%Game{phase: :resolve, player: %Player{hand: hand}}, _) do
    if Card.busted?(hand) do
      {:match, []}
    else
      :no_match
    end
  end

  def match(_, _), do: :no_match

  def apply(game, _) do
    game
    |> Game.dealer_win
  end
end
