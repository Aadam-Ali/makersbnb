require 'users'
require 'bcrypt'

RSpec.describe Users do

  describe '.create' do
    it 'adds a new user to the database and returns an users instance' do
      new_user = Users.create('jason@example.org', 'jason123', 'Jason')
      persisted_data = DatabaseConnection.query('SELECT * FROM users WHERE email = $1;', ['jason@example.org'])

      expect(new_user).to be_a(Users)
      expect(new_user.id).to eq(persisted_data[0]['id'])
      expect(new_user.name).to eq('Jason')
      expect(new_user.email).to eq('jason@example.org')
    end
    it 'stores the password encrypted into the database' do
      Users.create('freddy@example.org', 'freddy123', 'Freddy')
      persisted_data = DatabaseConnection.query('SELECT password FROM users WHERE email = $1;', ['freddy@example.org'])
      
      expect(persisted_data[0]['password']).not_to eq('freddy123')
      expect(BCrypt::Password.new(persisted_data[0]['password'])).to eq('freddy123')
    end
  end

  describe '.find_by_email' do
    context 'when user not in database' do
      it 'returns nil' do
        search_user = Users.find_by_email('freddy@example.org')
        expect(search_user).to be_nil
      end
    end
    context 'when user in database' do
      it 'returns an users instance' do
        new_user = Users.create('freddy@example.org', 'freddy123', 'Freddy')
        search_user = Users.find_by_email('freddy@example.org')
  
        expect(search_user).to be_a(Users)
        expect(search_user.id).to eq(new_user.id)
        expect(search_user.email).to eq(new_user.email)
        expect(search_user.name).to eq(new_user.name)
      end
    end
  end
end
