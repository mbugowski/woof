require_relative "../auth"

module Web::Controllers::Users
  class Edit
    include Web::Action
    include Web::Controllers::Auth
    expose :user

    def initialize(repository: UserRepository.new)
      @repository = repository
    end

    def call(params)
      return(status 404, "Not found") unless signed_in? && current_user?

      @user = @repository.find(params[:id])
      if @user.nil?
        status 404, "User not found"
      end
    end
  end
end
