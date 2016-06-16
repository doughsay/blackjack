defmodule Blackjack.Rules do
  alias Blackjack.Rules

  def run(game, inputs) do
    {_applied, game, _} = Enum.reduce(rules, {false, game, inputs}, &run_rule/2)

    # a second run through the rules is never needed...
    # if applied do
    #   run(game, %{})
    # end

    game
  end

  defp run_rule(rule, {applied, game, inputs}) do
    IO.puts "Running rule " <> to_string(rule)

    {rule_applied, game} =
      case rule.match(game, inputs) do
        {:match, args} ->
          IO.puts to_string(rule) <> " matched"
          {true, rule.apply(game, args)}
        :no_match ->
          {false, game}
      end

    {rule_applied || applied, game, inputs}
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
