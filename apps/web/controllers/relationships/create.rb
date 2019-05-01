module Web::Controllers::Relationships
  class Create
    include Web::Action

    params do
      required(:relationships).schema do
        required(:follower_id).filled
        required(:followed_id).filled
      end
    end

    def initialize(interactor: Follow.new)
      @interactor = interactor
    end

    def call(params)
      if params.valid?
        @interactor.call(params[:relationships])
        redirect_to routes.user_path(params[:relationships][:followed_id])
      end
    end
  end
end
