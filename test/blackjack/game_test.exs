defmodule BlackjackGameTest do
  use ExUnit.Case
  doctest Blackjack.Game

  alias Blackjack.Game

  describe "Blackjack.Game.new/0" do
    test "generates a new default game with a shuffled deck" do
      game = Game.new
      assert Enum.count(game.deck) == 52
      assert game.dealer_hand == []
      assert game.player.hand == []
      assert game.player.bet == 0
      assert game.player.bank == 100
      assert game.phase == :bet
    end
  end

  describe "Blackjack.Game.new/1" do
    test "generates a new game with a shuffled deck and the specified player bank value" do
      game = Game.new(200)
      assert Enum.count(game.deck) == 52
      assert game.dealer_hand == []
      assert game.player.hand == []
      assert game.player.bet == 0
      assert game.player.bank == 200
      assert game.phase == :bet
    end
  end

  describe "Blackjack.Game.dealer_win/1" do
    # TODO
  end

  describe "Blackjack.Game.player_win/1" do
    # TODO
  end

  describe "Blackjack.Game.push/1" do
    # TODO
  end
end
