defmodule AhonyaBidScraper do
  def main(_) do
    ClosedAuction.fetch |> ClosedAuction.format_auction
  end
end
