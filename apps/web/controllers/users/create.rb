module Web
  module Controllers
    module Users
      class Create
        include Web::Action
        include Hanami::Validations

        VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

        expose :user

        params do
          required(:user).schema do
            required(:name) { filled? & str? & size?(1..50) }
            required(:email) { filled? & str? & size?(1..255) & format?(VALID_EMAIL_REGEX) }
            required(:password) { filled? & str? & size?(6..64) }
          end
        end

        def initialize(interactor: AddUser.new)
          @interactor = interactor
        end

        def call(params)
          if params.valid?
            @user = @interactor.call(params[:user])
            params.env["warden"].set_user(@user)

            redirect_to routes.root_path
          else
            self.status = 422
          end
        end
      end
    end
  end
end
