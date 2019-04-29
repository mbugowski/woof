module Web
  module Controllers
    module Users
      class Update
        include Web::Action
        include Hanami::Validations

        VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
        expose :user

        params do
          required(:user).schema do
            required(:name) { filled? & str? & size?(1..50) }
            required(:email) { filled? & str? & size?(1..255) & format?(VALID_EMAIL_REGEX) }
          end
        end

        def initialize(interactor: UpdateUser.new)
          @interactor = interactor
        end

        def call(params)
          return(status 422) unless params.env["warden"].authenticated?

          @user = UserRepository.new.find(params[:id])
          if params.valid?
            @user = @interactor.call(params[:id], params[:user]).user
            redirect_to routes.user_path(@user.id)
          else
            self.status = 422
          end
        end
      end
    end
  end
end
