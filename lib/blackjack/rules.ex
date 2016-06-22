defmodule Blackjack.Rules do
  alias Blackjack.Rules

  def run(game, inputs) do
    Enum.reduce(rules, game, &run_rule(inputs, &1, &2))
  end

  defp run_rule(inputs, rule, game) do
    case rule.match(game, inputs) do
      {:match, args} -> rule.apply(game, args)
      :no_match      -> game
    end
  end

  defp rules do
    [
      Rules.Bet,
      Rules.Deal,
      Rules.BlackjackTie,
      Rules.DealerBlackjack,
      Rules.PlayerBlackjack,
      Rules.Hit,
      Rules.Stand,
      Rules.Bust,
      Rules.DealerPlay,
      Rules.Play,
      Rules.DealerBust,
      Rules.Win,
    ]
  end
end
