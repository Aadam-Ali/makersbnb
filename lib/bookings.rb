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
    return false unless available?(property_id, booking_date)
    result = DatabaseConnection.query('INSERT INTO bookings (property_id, customer_id, booking_date) VALUES ($1, $2, $3) RETURNING *;',
    [property_id, customer_name, booking_date])
    Bookings.new(result[0]['id'], result[0]['property_id'], result[0]['customer_id'], result[0]['booking_date'], result[0]['status'])
  end

  def self.find_by_customer_id(customer_id)
    results = DatabaseConnection.query('SELECT * FROM bookings WHERE customer_id = $1;', [customer_id])
    results.map { |booking| Bookings.new(booking['id'], booking['property_id'], booking['customer_id'], booking['booking_date'], booking['status']) }
  end

  def self.find_incoming_bookings(customer_id)
    results = DatabaseConnection.query('SELECT b.id, b.property_id, b.customer_id, b.booking_date, b.status
              FROM bookings as b 
              JOIN properties as p ON b.property_id = p.id
              WHERE owner_id = $1;', [customer_id])
    results.map { |booking| Bookings.new(booking['id'], booking['property_id'], booking['customer_id'], booking['booking_date'], booking['status'])}
  end

  def self.accept(booking_id)
    result = DatabaseConnection.query("UPDATE bookings SET status = 'accepted' WHERE id = $1 RETURNING *;", [booking_id])[0]
    Bookings.new(result['id'], result['property_id'], result['customer_id'], result['booking_date'], result['status'])
  end

  def self.reject(booking_id)
    result = DatabaseConnection.query("UPDATE bookings SET status = 'rejected' WHERE id = $1 RETURNING *;", [booking_id])[0]
    Bookings.new(result['id'], result['property_id'], result['customer_id'], result['booking_date'], result['status'])
  end

  private

  def self.available?(property_id, date)
    date = Date.parse(date)
    valid_dates = self.get_dates(property_id)

    return false unless date.between?(valid_dates[:available_from], valid_dates[:available_to])
    return false if self.booked_dates(property_id).include?(date)
    true
  end

  def self.get_dates(property_id)
    dates = DatabaseConnection.query("SELECT available_from, available_to FROM properties WHERE id = $1;", [property_id])[0]
    {available_from: Date.parse(dates['available_from']),
     available_to: Date.parse(dates['available_to'])}
  end

  def self.booked_dates(property_id)
    booked_dates = DatabaseConnection.query("SELECT booking_date FROM bookings WHERE property_id = $1 AND status = 'accepted';", [property_id])
    booked_dates.map { |date| Date.parse(date['booking_date'])}
  end
end
