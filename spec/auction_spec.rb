require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Auction do
  let(:item1) { Item.new('Chalkware Piggy Bank') }
  let(:item2) { Item.new('Bamboo Picture Frame') }
  let(:item3) { Item.new('Homemade Chocolate Chip Cookies') }
  let(:item4) { Item.new('2 Days Dogsitting') }
  let(:item5) { Item.new('Forever Stamps') }
  let(:attendee1) { Attendee.new({name: 'Megan', budget: '$50'}) }
  let(:attendee2) { Attendee.new({name: 'Bob', budget: '$75'}) }
  let(:attendee3) { Attendee.new({name: 'Mike', budget: '$100'}) }
  let(:auction) { Auction.new }
  
  it 'is a class with an items array, and records the items ' do
    expect(auction).to be_a Auction
    expect(auction.items).to eq([])
  end

  it 'can add items for auction and return the names of items in inventory' do
    expect(auction.item_names).not_to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    auction.add_item(item1)
    auction.add_item(item2)
    expect(auction.items).to eq([item1,item2])
    expect(auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
  end

  context 'testing the #unpopular_items and #potential_revenue' do
    before(:each) do      
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
    end

    it 'informs which items have no bids' do
      expect(auction.unpopular_items).to eq([item2, item3, item5])

      # item2

    end
  end
end