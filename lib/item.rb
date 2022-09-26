class Item
  attr_reader :name, :bids
  def initialize(name)
    @name = name
    @bids = Hash.new(0)
  end

  def add_bid(bidder, bid_amount)
  @bids[bidder] += bid_amount
  end

  def current_high_bid
    all_bids = []
    @bids.each { |person, amount| all_bids << amount }
    all_bids.max
  end

end