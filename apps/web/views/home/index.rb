module Web
  module Views
    module Home
      class Index
        include Web::View


        def page_title
          "Home"
        end
      end
    end
  end
end
