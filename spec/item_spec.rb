require './lib/item'
# require './lib/auction'
# require './lib/attendee'

RSpec.describe Item do
  let(:item1) { Item.new('Chalkware Piggy Bank') }
  let(:item2) { Item.new('Bamboo Picture Frame') }
  let(:item3) { Item.new('Homemade Chocolate Chip Cookies') }
  let(:item4) { Item.new('2 Days Dogsitting') }
  let(:item5) { Item.new('Forever Stamps') }

  it 'is a class with a name and bids hash' do
    expect(item2).to be_an_instance_of Item
    expect(item1.name).to eq("Chalkware Piggy Bank")
    expect(item3.bids).to eq({})
  end

  context 'testing bid related methods'do
    let(:attendee1) { Attendee.new({name: 'Megan', budget: '$50'}) }
    let(:attendee2) { Attendee.new({name: 'Bob', budget: '$75'}) }
    let(:attendee3) { Attendee.new({name: 'Mike', budget: '$100'}) }
    
    before(:each) do
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)
    end

    it'collects bids and can return the bidders with their offer' do
      expect(item1.bids).to eq({attendee2 => 20, attendee1 => 22})
      expect(item1.bids).not_to include({attendee3 => 50})
    end

    it 'informs what the highest bid is per item' do
      expect(item1.current_high_bid).to eq 22
      expect(item3.current_high_bid).not_to eq 50
    end
  end
end