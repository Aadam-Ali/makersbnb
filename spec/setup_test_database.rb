require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec("TRUNCATE bookings, properties;")
end

def add_row_to_database(name, description, price, owner)
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec("INSERT INTO properties (name, description, price, owner) values ('#{name}', '#{description}', '#{price}', '#{owner}') RETURNING * ;")
end