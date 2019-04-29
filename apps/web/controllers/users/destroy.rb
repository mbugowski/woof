module Web::Controllers::Users
  class Destroy
    include Web::Action

    def initialize(repository: UserRepository.new)
      @repository = repository
    end

    def call(params)
      return(status 422) unless signed_in? && current_user? && current_user.admin

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
