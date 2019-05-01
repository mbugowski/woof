module Web::Controllers::Users
  class Show
    include Web::Action
    expose :user

    def initialize(repository: UserRepository.new)
      @repository = repository
    end

    def call(params)
      @user = @repository.find_with_microposts(params[:id])
      if @user.nil?
        status 404, "User not found"
      end
    end
  end
end
