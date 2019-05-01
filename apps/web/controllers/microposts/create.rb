require_relative "../auth"

module Web::Controllers::Microposts
  class Create
    include Web::Action
    include Web::Controllers::Auth

    params do
      required(:micropost).schema do
        required(:user_id).filled(:str?)
        required(:content).filled(:str?)
      end
    end

    def initialize(interactor: AddMicropost.new)
      @interactor = interactor
    end

    def call(params)
      return(status 422) unless signed_in?

      if params.valid?
        @micropost = @interactor.call(params[:micropost])
      else
        self.status = 422
      end
      redirect_to routes.root_path
    end
  end
end
