CREATE TABLE users (id SERIAL PRIMARY KEY, email VARCHAR(255), password VARCHAR(32), name VARCHAR(30));
CREATE TABLE properties (id SERIAL PRIMARY KEY, name VARCHAR(30), description VARCHAR(255), price INT, owner_id INT REFERENCES users, available_from DATE, available_to DATE);
CREATE TABLE bookings (id SERIAL PRIMARY KEY, property_id INT REFERENCES properties, customer_id INT REFERENCES users, booking_date DATE, status VARCHAR(30) DEFAULT 'pending');
