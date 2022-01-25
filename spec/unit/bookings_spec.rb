require 'bookings'

describe Bookings do

  describe '.create' do
    it 'creates new bookings' do
      property = add_row_to_database('Small apartment', 'A small appartment in the city', 150, 'Alex')
      
      booking = Bookings.create(property.first['id'], 'Alex', '2022-02-02')
      
      expect(booking.property_id).to eq property.first['id']
      expect(booking.customer_name).to eq 'Alex'
      expect(booking.booking_date).to eq '2022-02-02'
    end
  end
end