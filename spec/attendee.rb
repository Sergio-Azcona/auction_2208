require './lib/item'
require './lib/attendee'

RSpec.describe Attendee do
  let(:attendee) { Attendee.new({name: 'Megan', budget: '$50'}) }
  let(:attendee2) { Attendee.new({name: 'Bob', budget: '$75'}) }
  let(:attendee3) { Attendee.new({name: 'Mike', budget: '$100'}) }

  it 'is a class with a name and budget attribute' do
    expect(attendee).to be_a Attendee
    expect(attendee.name).to eq("Megan")
    expect(attendee.budget).not_to eq('$50')
    expect(attendee.budget).to eq 50
  end
end