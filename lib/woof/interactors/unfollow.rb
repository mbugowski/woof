require "hanami/interactor"

class Unfollow
  include Hanami::Interactor

  def initialize(repository: UserRepository.new)
    @repository = repository
  end

  def call(relationship_params)
    follower = @repository.find(relationship_params[:follower_id])
    followed = @repository.find(relationship_params[:followed_id])

    follower.unfollow(followed)
  end
end

