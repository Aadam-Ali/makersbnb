require 'bookings'

describe Bookings do

  describe '.create' do
    it 'creates new bookings' do
      owner = DatabaseConnection.query("INSERT INTO users (email, password, name) VALUES ($1, $2, $3) RETURNING *;", ['test@test.com', 'password', 'Aadam'])
      customer = DatabaseConnection.query("INSERT INTO users (email, password, name) VALUES ($1, $2, $3) RETURNING *;", ['alex@test.com', 'password', 'Alex'])
      property = add_row_to_database('Small apartment', 'A small appartment in the city', 150, owner.first['id'], '2022-02-01', '2022-02-28')
      
      booking = Bookings.create(property.first['id'], customer.first['id'], '2022-02-02')
      
      expect(booking.property_id).to eq property.first['id']
      expect(booking.customer_id).to eq customer.first['id']
      expect(booking.booking_date).to eq '2022-02-02'
      expect(booking.status).to eq 'pending'
    end

    it 'returns unsuccesful when entering a date that is outside the available range' do
      owner = DatabaseConnection.query("INSERT INTO users (email, password, name) VALUES ($1, $2, $3) RETURNING *;", ['test@test.com', 'password', 'Aadam'])
      customer = DatabaseConnection.query("INSERT INTO users (email, password, name) VALUES ($1, $2, $3) RETURNING *;", ['alex@test.com', 'password', 'Alex'])
      property = add_row_to_database('Small apartment', 'A small appartment in the city', 150, owner.first['id'], '2022-02-01', '2022-02-28')

      booking = Bookings.create(property.first['id'], customer.first['id'], '2022-03-02')

      expect(booking).to eq false
    end
  end

  describe '.find_by_customer_id' do
    it 'filters bookings by customer id' do
      owner = DatabaseConnection.query("INSERT INTO users (email, password, name) VALUES ($1, $2, $3) RETURNING *;", ['test@test.com', 'password', 'Aadam'])
      customer = DatabaseConnection.query("INSERT INTO users (email, password, name) VALUES ($1, $2, $3) RETURNING *;", ['alex@test.com', 'password', 'Alex'])

      property_one = add_row_to_database('Small apartment', 'A small appartment in the city', 150, owner.first['id'], '2022-02-01', '2022-02-28')
      property_two = add_row_to_database('Medium apartment', 'A medium appartment in the city', 300, owner.first['id'], '2022-02-01', '2022-02-28')
      property_three = add_row_to_database('Large apartment', 'A large appartment in the city', 450, customer.first['id'], '2022-02-01', '2022-02-28')
      property_four = add_row_to_database('Extra large apartment', 'An extra large appartment in the city', 600, owner.first['id'], '2022-02-01', '2022-02-28')

      Bookings.create(property_one.first['id'], customer.first['id'], '2022-02-02')
      Bookings.create(property_two.first['id'], customer.first['id'], '2022-02-02')
      Bookings.create(property_three.first['id'], owner.first['id'], '2022-02-02')
      Bookings.create(property_four.first['id'], customer.first['id'], '2022-02-02')

      results = Bookings.find_by_customer_id(customer.first['id'])

      expect(results[0].property_id).to eq property_one.first['id']
      expect(results[1].property_id).to eq property_two.first['id']
      expect(results[2].property_id).to eq property_four.first['id']
    end
  end
end