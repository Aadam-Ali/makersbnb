class Bookings

  attr_reader :id, :property_id, :customer_name, :booking_date

  def initialize(id, property_id, customer_name, booking_date)
    @id = id
    @property_id = property_id
    @customer_name = customer_name
    @booking_date = booking_date
  end

  def self.create(property_id, customer_name, booking_date)
    result = DatabaseConnection.query('INSERT INTO bookings (property_id, customer_name, booking_date) VALUES ($1, $2, $3) RETURNING *;',
    [property_id, customer_name, booking_date])
    Bookings.new(result[0]['id'], result[0]['property_id'], result[0]['customer_name'], result[0]['booking_date'])
  end
end
