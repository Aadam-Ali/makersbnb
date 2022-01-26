class Properties
  attr_reader :id, :name, :description, :price, :owner_id, :available_from, :available_to

  def initialize(id, name, description, price, owner_id, available_from, available_to)
    @id = id
    @name = name
    @description = description
    @price = price
    @owner_id = owner_id
    @available_from = available_from
    @available_to = available_to
  end

  def self.all 
    results = DatabaseConnection.query('SELECT * FROM properties;', nil)
    results.map { |result| Properties.new(result['id'], result['name'], result['description'], result['price'], result['owner_id'], result['available_from'], result['available_to'])}
  end

  def self.create(name, description, price, owner_id, available_from, available_to)
    result = DatabaseConnection.query('INSERT INTO properties (name, description, price, owner_id, available_from, available_to) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *;',
                                       [name, description, price, owner_id, available_from, available_to])
    Properties.new(result[0]['id'], result[0]['name'], result[0]['description'], result[0]['price'], result[0]['owner_id'], result[0]['available_from'], result[0]['available_to'])
  end

  def self.find_by_id(id)
    result = DatabaseConnection.query('SELECT * FROM properties WHERE id = $1;', [id])
    Properties.new(result[0]['id'], result[0]['name'], result[0]['description'], result[0]['price'], result[0]['owner_id'], result[0]['available_from'], result[0]['available_to'])
  end 
end