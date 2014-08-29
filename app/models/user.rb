class User < ActiveRecord::Base
  validates :username, :session_token, presence: true
  validates :username, uniqueness: true
  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :password, length: { minimum: 8, allow_nil: true }
  
  after_initialize :ensure_session_token
  
  attr_reader :password
  
  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    
    user.is_password?(password) ? user : nil
  end

  
  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password? password
    BCrypt::Password.new(self.password_digest) == password
  end
  
  private
  
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
  
end
