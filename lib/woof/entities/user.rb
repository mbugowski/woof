require "bcrypt"

class User < Hanami::Entity
  def password
    BCrypt::Password.new(encrypted_password)
  end
end
