defmodule AhonyaScraperTest do
  use ExUnit.Case
  doctest AhonyaBidScraper





  test "total auction is an integer" do
    assert is_integer ClosedAuction.total_auction(TestData.html)
  end

  test "total auction is 96" do
    assert ClosedAuction.total_auction(TestData.html) == 96
  end

  test "convert ahonyabid bid to GHC equivalent" do
    assert ClosedAuction.bid_to_cedis(14.11) == 705.5
  end

  test "Auctions get converted to Auction structs" do
    assert ClosedAuction.get_auctions(TestData.html) |> Enum.take(1) == [%Auction{market_price: "400.00",
             product: "Itel iNote Prime", sold_at: "705.50", profit_loss: "305.50", winner: "odasani"}]
  end

  test "Highest auction" do
    assert ClosedAuction.highest_auction(TestData.html) == %Auction{market_price: "4000.00", product: "Apple iPhone 6s 16Gb",
            sold_at: "14105.50", profit_loss: "10105.50", winner: "adwen233"}
  end
end
