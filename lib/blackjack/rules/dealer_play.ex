defmodule Blackjack.Rules.DealerPlay do
  alias Blackjack.{Game, Card, Dealer}

  def match(%Game{phase: :dealer_play}, _), do: {:match, []}
  def match(_, _), do: :no_match

  def apply(game, _) do
    game = make_dealer_move(game)
    %{game | phase: :resolve_end}
  end

  defp make_dealer_move(game = %Game{dealer_hand: hand}) do
    hand
    |> Card.score
    |> Dealer.move
    |> make_move(game)
  end

  defp make_move(:stand, game), do: game
  defp make_move(:hit, game) do
    game
    |> Game.dealer_hit
    |> make_dealer_move
  end
end
