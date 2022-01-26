require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec("TRUNCATE bookings, properties, users;")
end

def add_row_to_database(name, description, price, owner_id, available_from, available_to)
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec("INSERT INTO properties (name, description, price, owner_id, available_from, available_to) values ('#{name}', '#{description}', '#{price}', #{owner_id}, '#{available_from}', '#{available_to}') RETURNING * ;")
end

def add_rows_to_database
  connection = PG.connect(dbname: 'makersbnb_test')

  aadam = connection.exec_params("INSERT INTO users (email, password, name) VALUES ($1, $2, $3) RETURNING *;", ['test@test.com', 'password', 'Aadam'])
  alex = connection.exec_params("INSERT INTO users (email, password, name) VALUES ($1, $2, $3) RETURNING *;", ['alex@test.com', 'password', 'Alex'])
  dave = connection.exec_params("INSERT INTO users (email, password, name) VALUES ($1, $2, $3) RETURNING *;", ['dave@test.com', 'password', 'Dave'])

  add_row_to_database('Small Cottage', 'A small cottage in the countryside', 35, aadam.first['id'], '2022-02-01', '2022-02-28')
  add_row_to_database('Medium Cottage', 'A medium cottage in the countryside', 50, alex.first['id'], '2022-02-01', '2022-02-28')
  add_row_to_database('Large Cottage', 'A large cottage in the countryside', 100, dave.first['id'], '2022-02-01', '2022-02-28')
end

def add_row_to_users
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec("INSERT INTO users (email, password, name) VALUES ('test@test.com', 'password', 'Aadam') RETURNING *;")
end