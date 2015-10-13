defmodule ClosedAuction do

  import AhonyaBid.TableFormater, only: [ print_table_columns: 2 ]

  @ahonyabid_url Application.get_env(:ahonyabid_scraper, :ahonyabid_url)
  @closed_auction_url @ahonyabid_url <> "/auction/closed/?limit=1000"

  def fetch(url \\ @closed_auction_url) do
    case HTTPoison.get(url) do
     {:ok, %HTTPoison.Response{status_code: 200, body: html}} ->
       html
     {:ok, %HTTPoison.Response{status_code: 404}} ->
         IO.puts "Not found :("
     {:error, %HTTPoison.Error{reason: reason}} ->
         IO.inspect reason
     end
  end

  def get_auctions(html) do
    Floki.find(html, "#closedAuc")
    |> Floki.find(".col-sm-3 p")
    |> Enum.chunk(5)
    |> to_struct_list
  end

  def format_auction(html) do
    get_auctions(html) |> print_table_columns(["market_price", "product", "sold_at", "winner"])
  end

  def get_total_page(html) do
    Floki.find(html, ".pagination li a")
    |> Floki.attribute("href")
    |> Enum.at(-2)
    |> binary_part(6,2)
    |> String.to_integer(10)
  end

  ## Convert auctions to list of %Auction{} structs
  defp to_struct_list(auctions) do
    auctions
    |> Enum.map(&auction_to_struct/1)
  end

  ## Convert extracted auction to %Auction{} struct
  defp auction_to_struct(auction) do
    case auction do
      [{_,_,[name]}, {_,_,[m_price]}, {_,_,_}, {_,_,[sold]},{_,_,[winner]}]
        -> %Auction{product: name,
                    market_price: m_price |> strip_ghc |> Float.to_string(decimals: 2),
                    sold_at: sold |> strip_ghc |> bid_to_cedis |> Float.to_string(decimals: 2),
                    winner: winner}
    end
  end

  @doc """
  Get highest auction
  """
  def highest_auction(html) do
    get_auctions(html) |> Enum.max_by(fn auc -> auc.sold_at |> String.to_float end)
  end

  @doc """
   converts ahonyabid bids to Ghana cedis equivalent.
   One ahonyabid equals GHC 0.50
   Example
   iex> bid_to_cedis(14.11)
   705.5
  """
  def bid_to_cedis(bid) do
    bid * 100 * 0.50
  end

  defp strip_ghc(money) do
    [bid] = money |> String.split(" ") |> Enum.take(-1)
    String.to_float(bid)
  end

  def format_float(number) do
    [value] = :io_lib.format("~.2f", [number])
    value
  end

  ## Extract the url for fetching all the closed auctions
  def get_full_url(html) do
    [[{_, [{_, url}], _}]] = parse_limit(html)
    @ahonyabid_url <> url
  end

  @doc """
  Returns total number of closed auctions
  """
  def total_auction(html) do
    [[{_, _, [limit]}]] = parse_limit(html)
    String.to_integer(limit)
  end

  ## Get the last element that controls the number of auctions displayed
  ## per page
  defp parse_limit(html) do
    Floki.find(html, ".dropdown-menu li a")
    |> Enum.chunk(1)
    |> Enum.take(-1)
  end


end
