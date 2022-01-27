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

  describe '.autheticate' do
    it 'returns nil when email not in database' do
      unknown_user = Users.authenticate('unknown@example.org', 'freddy123')

      expect(unknown_user).to be_nil
    end
    it 'returns nil when wrong password ' do
      Users.create('freddy@example.org', 'freddy123', 'Freddy')
      user_pw_incorrect = Users.authenticate('freddy@example.org', 'incorrect')

      expect(user_pw_incorrect).to be_nil
    end
    it 'returns a user when email and password are correct' do
      user = Users.create('freddy@example.org', 'freddy123', 'Freddy')
      auth_user = Users.authenticate('freddy@example.org', 'freddy123')

      expect(auth_user).to be_a(Users)
      expect(auth_user.id).to eq(user.id)
      expect(auth_user.email).to eq(user.email)
      expect(auth_user.name).to eq(user.name)
    end
  end
end
