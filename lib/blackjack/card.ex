defmodule Blackjack.Card do
  defstruct rank: :ace, suit: :spades, facing: :up

  import Blackjack.Macros

  alias Blackjack.Card

  @doc ~S"""
  ## Examples:

      iex> Blackjack.Card.score([%Blackjack.Card{rank: :ace}, %Blackjack.Card{rank: 6}])
      {17, :soft}

      iex> Blackjack.Card.score([%Blackjack.Card{rank: :ace}, %Blackjack.Card{rank: 6}, %Blackjack.Card{rank: 5}])
      {12, :hard}
  """
  def score(cards) do
    cards
    |> Enum.sort_by(&value/1)
    |> Enum.reduce({0, :hard}, &update_score/2)
  end

  def blackjack?(cards) do
    Enum.count(cards) == 2 && elem(score(cards), 0) == 21
  end

  def busted?(cards) do
    {sum, _} = score(cards)
    sum > 21
  end

  defp value(%Card{rank: :ace}), do: 11
  defp value(%Card{rank: rank})  when face(rank), do: 10
  defp value(%Card{rank: rank}), do: rank

  defp update_score(%Card{rank: :ace}, {sum, _})    when sum <  11,  do: {sum + 11, :soft}
  defp update_score(%Card{rank: :ace}, {sum, _})    when sum >= 11,  do: {sum + 1,  :hard}
  defp update_score(%Card{rank: rank}, {sum, type}) when face(rank), do: {sum + 10, type}
  defp update_score(%Card{rank: rank}, {sum, type}), do: {sum + rank, type}

  defimpl Inspect, for: Card do
    def inspect(card, _) do
      "#<%Blackjack.Card{#{card.rank} of #{card.suit}}>"
    end
  end
end
