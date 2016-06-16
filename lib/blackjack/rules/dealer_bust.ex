defmodule Blackjack.Rules.DealerBust do
  alias Blackjack.{Game, Card}

  def match(%Game{phase: :resolve_end, dealer_hand: hand}, _) do
    if Card.busted?(hand) do
      {:match, []}
    else
      :no_match
    end
  end

  def match(_, _), do: :no_match

  def apply(game, _) do
    game
    |> Game.player_win
  end
end
