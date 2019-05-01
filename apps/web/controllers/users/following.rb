module Web::Controllers::Users
  class Following
    include Web::Action

    expose :following, :microposts_count, :title, :user

    def initialize(interactor: GetFollowing.new)
      @interactor = interactor
    end

    def call(params)
      @title = "Following"
      data = @interactor.call(params[:id]).data
      @user = data[:user]
      @following = data[:following]
      @microposts_count = data[:microposts_count]
    end
  end
end

