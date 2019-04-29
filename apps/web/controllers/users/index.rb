module Web
  module Controllers
    module Users
      class Index
        include Web::Action
        include Pagy::Backend

        expose :users, :pagy_data

        def initialize(repository: UserRepository.new)
          @repository = repository
        end

        def call(params)
          @pagy_data, @users = pagy(@repository)
        end

        def pagy_get_items(repo, pagy)
          repo.page(pagy.offset, pagy.items)
        end
      end
    end
  end
end
