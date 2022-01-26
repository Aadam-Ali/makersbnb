class Users

  attr_reader :id, :email, :password, :name

  def initialize(id, email, password, name)
    @id = id
    @email = email
    @password = password
    @name = name
  end

  def self.create(email, password, name)
    user_details = [email, password, name]
    result = DatabaseConnection.query("INSERT INTO users (email, password, name) 
                                      VALUES($1, $2, $3) RETURNING *;" , user_details)
    Users.new(result[0]['id'], result[0]['email'], result[0]['password'], result[0]['name'])
  end

  def self.find_by_email(email)
    result = DatabaseConnection.query("SELECT * FROM users WHERE email = $1;", [email])
    Users.new(result[0]['id'], result[0]['email'], result[0]['password'], result[0]['name'])
  end
end
