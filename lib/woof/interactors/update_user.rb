require "hanami/interactor"

class UpdateUser
  include Hanami::Interactor

  expose :user

  def initialize(repository: UserRepository.new)
    @repository = repository
  end

  def call(id, user_attributes)
    @user = @repository.update(id, user_attributes)
  end
end
