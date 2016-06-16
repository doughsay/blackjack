defmodule Blackjack.Rules.BlackjackTie do
  alias Blackjack.{Game, Card, Player}

  def match(%Game{phase: :resolve, dealer_hand: dealer_hand, player: %Player{hand: player_hand}}, _) do
    import Card, only: [blackjack?: 1]

    if blackjack?(dealer_hand) && blackjack?(player_hand) do
      {:match, []}
    else
      :no_match
    end
  end

  def match(_, _), do: :no_match

  def apply(game, _) do
    game
    |> Game.push
  end
end
