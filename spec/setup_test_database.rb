require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec("TRUNCATE bookings, properties;")
end

def add_row_to_database(name, description, price, owner)
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec("INSERT INTO properties (name, description, price, owner) values ('#{name}', '#{description}', '#{price}', '#{owner}') RETURNING * ;")
end

def add_rows_to_database
  add_row_to_database('Small Cottage', 'A small cottage in the countryside', 35, 'Aadam')
  add_row_to_database('Medium Cottage', 'A medium cottage in the countryside', 50, 'Alex')
  add_row_to_database('Large Cottage', 'A large cottage in the countryside', 100, 'Dave')
end
