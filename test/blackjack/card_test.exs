defmodule BlackjackCardTest do
  use ExUnit.Case
  doctest Blackjack.Card

  alias Blackjack.Card

  describe "Blackjack.Card.score/1" do
    test "basic cards" do
      cards = [%Card{rank: 4, suit: :hearts}, %Card{rank: 10, suit: :hearts}]
      assert Card.score(cards) == {14, :hard}
    end

    test "count face cards as 10" do
      cards = [%Card{rank: :jack, suit: :hearts}, %Card{rank: 10, suit: :hearts}]
      assert Card.score(cards) == {20, :hard}
    end

    test "count ace as 11 when total would not be over 21" do
      cards = [%Card{rank: :ace, suit: :hearts}, %Card{rank: 10, suit: :hearts}]
      assert Card.score(cards) == {21, :soft}
    end

    test "count ace as 1 when total would be over 21 if counted as 11" do
      cards = [%Card{rank: :ace, suit: :hearts}, %Card{rank: 10, suit: :hearts}, %Card{rank: 2, suit: :hearts}]
      assert Card.score(cards) == {13, :hard}
    end

    test "count two aces as different values to keep from busting" do
      cards = [%Card{rank: :ace, suit: :hearts}, %Card{rank: :ace, suit: :spades}]
      assert Card.score(cards) == {12, :hard}
    end
  end

  describe "Blackjack.Card.blackjack?/1" do
    test "true for blackjack" do
      cards = [%Card{rank: :ace}, %Card{rank: :jack}]
      assert Card.blackjack?(cards)
    end

    test "false for 21 that's not a blackjack" do
      cards = [%Card{rank: 5}, %Card{rank: 5}, %Card{rank: :ace}]
      refute Card.blackjack?(cards)
    end

    test "false for other hands" do
      cards = [%Card{rank: 2}, %Card{rank: :jack}]
      refute Card.blackjack?(cards)
    end
  end

  describe "Blackjack.Card.busted?/1" do
    test "true for hands that total over 21" do
      cards = [%Card{rank: :king}, %Card{rank: :jack}, %Card{rank: 2}]
      assert Card.busted?(cards)
    end

    test "false for other hands" do
      cards = [%Card{rank: :king}, %Card{rank: :jack}]
      refute Card.busted?(cards)
    end
  end

  describe "inspect implementation" do
    test "it returns an easy to read representation of the card" do
      assert inspect(%Card{rank: :ace, suit: :spades}) == "#<%Blackjack.Card{ace of spades}>"
    end
  end
end
