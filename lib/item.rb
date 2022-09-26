class Item
  attr_reader :name, :bids
  def initialize(name)
    @name = name
    @bids = Hash.new(0)
    @open_bidding = true
  end

  def add_bid(bidder, bid_amount)
    @bids[bidder] += bid_amount if @open_bidding == true
  end

  def current_high_bid
    all_bids = []
    @bids.each { |person, amount| all_bids << amount }
    all_bids.max
  end

  def close_bidding
     @open_bidding = false
  end
end