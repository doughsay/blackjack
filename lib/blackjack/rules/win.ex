defmodule Blackjack.Rules.Win do
  alias Blackjack.{Game, Player, Card}

  def match(%Game{phase: :resolve_end}, _), do: {:match, []}
  def match(_, _), do: :no_match

  def apply(game = %Game{dealer_hand: dealer_hand, player: %Player{hand: player_hand}}, _) do
    player_score = Card.score(player_hand)
    dealer_score = Card.score(dealer_hand)
    cond do
      player_score > dealer_score ->
        Game.player_win(game)
      player_score < dealer_score ->
        Game.dealer_win(game)
      :else ->
        Game.push(game)
    end
  end
end
