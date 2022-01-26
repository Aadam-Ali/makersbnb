require 'users'

RSpec.describe Users do

  describe '.create' do
    it 'adds a new user to the database and returns an users instance' do
      old_user = DatabaseConnection.query('INSERT INTO users (email, password, name) 
      VALUES($1, $2, $3) RETURNING *;', ['freddy@example.org', 'freddy123', 'Freddy'])

      new_user = Users.create('jason@example.org', 'jason123', 'Jason')

      expect(new_user).to be_a(Users)
      expect(new_user.id.to_i - old_user[0]['id'].to_i).to be 1
      expect(new_user.name).to eq('Jason')
      expect(new_user.password).to eq('jason123')
      expect(new_user.email).to eq('jason@example.org')
    end
  end

  describe '.find_by_email' do
    context 'when user in database' do
      it 'returns an users instance' do
        new_user = Users.create('freddy@example.org', 'freddy123', 'Freddy')
        search_user = Users.find_by_email('freddy@example.org')
  
        expect(search_user).to be_a(Users)
        expect(search_user.id).to eq(new_user.id)
        expect(search_user.email).to eq(new_user.email)
        expect(search_user.password).to eq(new_user.password)
        expect(search_user.name).to eq(new_user.name)
      end
    end
    context 'when user not in database' do
      it 'returns nil' do
        search_user = Users.find_by_email('freddy@example.org')
        expect(search_user).to be_nil
      end
    end
  end
end
