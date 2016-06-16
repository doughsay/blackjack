defmodule Blackjack.Deck do
  alias Blackjack.Card

  def new do
    [:clubs, :diamonds, :hearts, :spades]
    |> Enum.flat_map(&sub_deck/1)
  end

  def draw(deck), do: draw(deck, 1)
  def draw(deck, n) do
    Enum.split(deck, n)
  end

  defdelegate shuffle(deck), to: Enum

  defp sub_deck(suit) do
    2..10
    |> Enum.concat([:jack, :queen, :king, :ace])
    |> Enum.map(fn(rank) -> %Card{rank: rank, suit: suit} end)
  end
end
