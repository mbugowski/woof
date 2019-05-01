require_relative "../auth"

module Web::Controllers::Users
  class Destroy
    include Web::Action
    include Web::Controllers::Auth

    def initialize(repository: UserRepository.new)
      @repository = repository
    end

    def call(params)
      return(status 422, "something went wrong") unless signed_in? && current_user.admin

      user = @repository.find(params[:id])
      if user
        @repository.delete(user.id)
        redirect_to routes.users_path
      else
        self.status = 422
      end
    end
  end
end
