class User < Sequel::Model
  one_to_many :articles
  one_to_many :posts

  set_schema do
    primary_key :id
    String :username, null: false
    String :password, null: false
    String :token

    index :username, unique: true
    index :token, unique: true
  end

  create_table unless table_exists?

  def before_create
    self.token = SecureRandom.hex(16)
  end

  def self.authenticate(creds)
    username, password = creds['username'], creds['password']

    if blank?(username) || blank?(password)
      return false
    end

    user = where(username: username).first

    if user && user.password == password
      return user
    else
      return false
    end
  end

  def self.exists?(username)
    !where(username: username).first.nil?
  end

  def set_password(password: nil, confirmation: nil)
    if blank?(password) || blank?(confirmation)
      return
    elsif password != confirmation
      return
    end

    self.password = BCrypt::Password.create(password, cost: 10)
  end

  def password
    password = super

    if !password.nil?
      return BCrypt::Password.new(password)
    else
      return nil
    end
  end

  private
  def self.blank?(str)
    str.nil? || str.length <= 0
  end

  def blank?(str)
    User.blank?(str)
  end
end
