require 'properties'

describe Properties do
  describe '.all' do
    it 'returns all properties' do
      add_rows_to_database

      properties = Properties.all

      expect(properties[0].name).to eq 'Small Cottage'
      expect(properties[1].name).to eq 'Medium Cottage'
      expect(properties[2].name).to eq 'Large Cottage'
    end
  end

  describe '.create' do
    it 'creates a property' do
      owner = DatabaseConnection.query("INSERT INTO users (email, password, name) VALUES ($1, $2, $3) RETURNING *;", ['test@test.com', 'password', 'Aadam'])
      property = Properties.create('Extra Large Cottage', 'A extra large cottage in the countryside', 150, owner.first['id'], '2022-02-01', '2022-02-28')
      
      result = Properties.all
      
      expect(result[0].id).to eq property.id
      expect(result[0].name).to eq property.name
      expect(result[0].description).to eq property.description
      expect(result[0].price).to eq property.price
      expect(result[0].owner_id).to eq owner.first['id']
      expect(result[0].available_from).to eq property.available_from
      expect(result[0].available_to).to eq property.available_to
    end
  end

  describe '.find_by_id' do
    it 'finds a property by id' do
      add_rows_to_database
      owner = DatabaseConnection.query("INSERT INTO users (email, password, name) VALUES ($1, $2, $3) RETURNING *;", ['test@test.com', 'password', 'Aadam'])
      property = Properties.create('Extra Large Cottage', 'A extra large cottage in the countryside', 150, owner.first['id'], '2022-02-01', '2022-02-28')

      result = Properties.find_by_id(property.id)
      
      expect(result.id).to eq property.id
      expect(result.name).to eq property.name
      expect(result.description).to eq property.description
      expect(result.price).to eq property.price
      expect(result.owner_id).to eq property.owner_id
      expect(result.available_from).to eq property.available_from
      expect(result.available_to).to eq property.available_to
    end
  end
end