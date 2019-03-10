module Web
  module Views
    module About
      class Index
        include Web::View

        def page_title
          "About"
        end
      end
    end
  end
end
