defmodule Blackjack.Rules.Bet do
  alias Blackjack.{Game, Player}

  def match(%Game{phase: :bet, player: %Player{bank: bank}}, %{bet: bet})
      when bet > 0 and bet <= bank, do: {:match, [bet]}
  def match(_, _), do: :no_match

  def apply(game, [amount]) do
    game
    |> Game.bet(amount)
    |> Game.phase(:deal)
  end
end
