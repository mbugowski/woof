module Web
  module Views
    module Users
      class Index
        include Web::View
        include Web::Views::Shared::GravatarFor
        include Pagy::Frontend

        def page_title
          "All users"
        end

        def pagy_url_for(page, pagy)
          options = { pagy_data.vars[:page_params] => page }.merge(pagy_data.vars[:params])
          routes.path(:users, options)
        end

        def pagy_bootstrap_nav(*args)
          _raw super
        end

        def pagy_bootstrap_nav_js(*args)
          _raw super
        end
      end
    end
  end
end
