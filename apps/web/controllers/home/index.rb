module Web
  module Controllers
    module Home
      class Index
        include Web::Action
        expose :user

        def call(params)
          current_user = params.env["warden"].user
          @user = UserRepository.new.find_with_microposts(current_user.id)
        end
      end
    end
  end
end
