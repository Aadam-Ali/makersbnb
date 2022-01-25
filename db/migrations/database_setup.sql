CREATE TABLE properties (id SERIAL PRIMARY KEY, name VARCHAR(30), description VARCHAR(255), price INT, owner VARCHAR(30));
CREATE TABLE bookings (id SERIAL PRIMARY KEY, property_id INT REFERENCES properties, customer_name VARCHAR(30), booking_date DATE)
