require "hanami/interactor"

class GetFollowing
  include Hanami::Interactor

  expose :data

  def initialize(
    user_repo: UserRepository.new,
    micropost_repo: MicropostRepository.new
  )
    @user_repo = user_repo
    @micropost_repo = micropost_repo
  end

  def call(user_id)
    user = @user_repo.find(user_id)
    following = @user_repo.find_following(user_id).to_a
    microposts_count = @micropost_repo.count_for_user(user_id)
    @data = { user: user, following: following, microposts_count: microposts_count }
  end
end
