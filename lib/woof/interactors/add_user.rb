require "hanami/interactor"
require "bcrypt"

class AddUser
  include Hanami::Interactor

  expose :user

  def initialize(repository: UserRepository.new)
    @repository = repository
  end

  def call(user_attributes)
    if user_attributes[:password]
      user_attributes = user_attributes.merge(
        encrypted_password: encrypt(user_attributes[:password]),
      )
      user_attributes.delete(:password)
    end

    @user = @repository.create(user_attributes)
  end

  private

  def encrypt(password)
    BCrypt::Password.create(password, cost: 12)
  end
end
