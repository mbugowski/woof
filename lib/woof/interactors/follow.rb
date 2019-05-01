require "hanami/interactor"

class Follow
  include Hanami::Interactor

  def initialize(repository: UserRepository.new)
    @repository = repository
  end

  def call(relationship_params)
    follower = @repository.find(relationship_params[:follower_id])
    followed = @repository.find(relationship_params[:followed_id])

    follower.follow(followed)
  end
end
