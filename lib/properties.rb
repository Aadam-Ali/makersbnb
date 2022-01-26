class Properties
  attr_reader :id, :name, :description, :price, :owner

  def initialize(id, name, description, price, owner)
    @id = id
    @name = name
    @description = description
    @price = price
    @owner = owner
  end

  def self.all 
    results = DatabaseConnection.query('SELECT * FROM properties;', nil)
    results.map { |result| Properties.new(result['id'], result['name'], result['description'], result['price'], result['owner'])}
  end

  def self.create(name, description, price, owner)
    result = DatabaseConnection.query('INSERT INTO properties (name, description, price, owner) VALUES ($1, $2, $3, $4) RETURNING *;',
                                       [name, description, price, owner])
    Properties.new(result[0]['id'], result[0]['name'], result[0]['description'], result[0]['price'], result[0]['owner'])
  end

  def self.find_by_id(id)
    result = DatabaseConnection.query('SELECT * FROM properties WHERE id = $1;', [id])
    Properties.new(result[0]['id'], result[0]['name'], result[0]['description'], result[0]['price'], result[0]['owner'])
  end 
end