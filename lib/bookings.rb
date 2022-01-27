class Bookings

  attr_reader :id, :property_id, :customer_id, :booking_date, :status

  def initialize(id, property_id, customer_id, booking_date, status)
    @id = id
    @property_id = property_id
    @customer_id = customer_id
    @booking_date = booking_date
    @status = status
  end

  def self.create(property_id, customer_name, booking_date)
    result = DatabaseConnection.query('INSERT INTO bookings (property_id, customer_id, booking_date) VALUES ($1, $2, $3) RETURNING *;',
    [property_id, customer_name, booking_date])
    Bookings.new(result[0]['id'], result[0]['property_id'], result[0]['customer_id'], result[0]['booking_date'], result[0]['status'])
  end
end
