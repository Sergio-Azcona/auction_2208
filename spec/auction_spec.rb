require './lib/item'
require './lib/auction'
require './lib/attendee'
require 'date'

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

  describe 'testing the #unpopular_items and #potential_revenue' do
    before(:each) do      
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      item1.add_bid(attendee1, 22)
      item1.add_bid(attendee2, 20)
      item4.add_bid(attendee3, 50)
    end

    it 'keeps a running list of items have no bids and updates the list when bids are sumbitted' do
      expect(auction.unpopular_items).not_to eq([item1,item4])
      expect(auction.unpopular_items).to eq([item2,item3,item5])
      item3.add_bid(attendee2, 15)
      expect(auction.unpopular_items).to eq([item2,item5])
      expect(auction.unpopular_items).not_to include([item3])
    end

    it "calculates total possible sale price of all items (the item's highest bid)" do
      item3.add_bid(attendee2, 15)
      expect(auction.potential_revenue).to eq 87
    end
  

    context 'testing #bidders, #close_bidding, #bidder_info' do
      before(:each) do
        item3.add_bid(attendee2, 15)
      end

      it 'returns the names of the bidders' do
        expect(auction.bidders).to eq(["Megan", "Bob", "Mike"])
      end
    
      it 'informs the attendee budget and items that attendee has bid on' do
        bidder_data = 
        {
           attendee1 =>
             {
               :budget => 50,
               :items => [item1]
             },
           attendee2 =>
             {
               :budget => 75,
               :items => [item1,item3]
             },
           attendee3 =>
             {
               :budget => 100,
               :items => [item4]
             }
          }

          expect(auction.bidder_info).to eq(bidder_data)
      end
    
      it 'returns a string representation of the date in the format: dd/mm/yyyy' do
        event_date = "24/02/2020"
        allow(auction).to receive(:date).and_return(event_date)
        expect(auction.date).to eq("24/02/2020")
      end

    end
  end
end