defmodule BlackjackDeckTest do
  use ExUnit.Case
  doctest Blackjack.Deck

  alias Blackjack.Deck

  describe "Blackjack.Deck.new/0" do
    test "returns 52 unique cards" do
      cards = Deck.new
      assert cards |> Enum.count == 52
      assert cards |> Enum.uniq |> Enum.count == 52
    end
  end

  describe "Blackjack.Deck.draw/1" do
    test "removes the top card from the deck and returns it" do
      cards = Deck.new
      top_card = hd cards
      {[drawn_card], cards} = Deck.draw(cards)
      assert drawn_card == top_card
      assert Enum.count(cards) == 51
    end
  end

  describe "Blackjack.Deck.draw/2" do
    test "removes the top n cards from the deck and returns them" do
      cards = Deck.new
      {top_3_cards, _} = Enum.split(cards, 3)
      {drawn_cards, cards} = Deck.draw(cards, 3)
      assert drawn_cards == top_3_cards
      assert Enum.count(cards) == 49
    end
  end
end
