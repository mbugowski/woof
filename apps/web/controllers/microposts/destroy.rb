require_relative "../auth"

module Web::Controllers::Microposts
  class Destroy
    include Web::Action
    include Web::Controllers::Auth

    def initialize(repository: MicropostRepository.new)
      @repository = repository
    end

    def call(params)
      return(status 422, "something went wrong") unless signed_in?
      micropost = @repository.find(params[:id])
      if micropost current_user.id == micropost.user_id
        @repository.delete(micropost.id)
        redirect_to routes.root_path
      else
        self.status = 422
      end
    end
  end
end
