module Web::Controllers::Users
  class Followers
    include Web::Action

    expose :followers, :microposts_count, :title, :user

    def initialize(interactor: GetFollowers.new)
      @interactor = interactor
    end

    def call(params)
      @title = "Followers"
      data = @interactor.call(params[:id]).data
      @user = data[:user]
      @followers = data[:followers]
      @microposts_count = data[:microposts_count]
    end
  end
end
