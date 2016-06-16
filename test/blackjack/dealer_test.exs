defmodule BlackjackDealerTest do
  use ExUnit.Case
  doctest Blackjack.Dealer

  alias Blackjack.Dealer

  describe "Blackjack.Dealer.move/1" do
    test "dealer hits on soft 17" do
      # Application.get_env(:blackjack, :dealer_hit_on_soft_17)
      assert Dealer.move({17, :soft}) == :hit
    end

    test "dealer stands on hard 17" do
      assert Dealer.move({17, :hard}) == :stand
    end

    test "dealer hits on 16 and below" do
      2..16
      |> Enum.each(fn(sum) ->
        assert Dealer.move({sum, :soft}) == :hit
        assert Dealer.move({sum, :hard}) == :hit
      end)
    end

    test "dealer stands on anything above 17" do
      18..21
      |> Enum.each(fn(sum) ->
        assert Dealer.move({sum, :soft}) == :stand
        assert Dealer.move({sum, :hard}) == :stand
      end)
    end
  end
end
