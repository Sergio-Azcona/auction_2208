class Auction
  attr_reader :items,:date
  def initialize
    @items = []
    @date = Time.now.strftime("%d/%m/%Y")
  end

  def add_item(item)
    @items.push(item)
  end

  def item_names
    @items.map { |item| item.name}
  end

  def unpopular_items
    @items.select { |item| item.bids.any? == false }     
  end

  def potential_revenue
    potential_windfall = 0
    @items.find_all do |item|
      if unpopular_items.include?(item) == false
       potential_windfall += item.current_high_bid
      end
    end
    potential_windfall 
  end

  def bidders
    bidder_list = []
    @items.each do |item|
      if unpopular_items.include?(item) == false
        item.bids.select do |attendee, bid|
          bidder_list << attendee.name
        end
      end
    end 
    bidder_list.uniq
  end

  def bidder_info
    bidding_data = Hash.new { |h,k| h[k] = { :budget => 0,:items => [] } }
    @items.each do |item|
        item.bids.select do |attendee, bid|
          bidding_data[attendee][:budget] = attendee.budget
          bidding_data[attendee][:items] << item
      end
    end
    bidding_data
  end
end