module Web
  module Views
    class ApplicationLayout
      include Web::Layout

      def page_title
        ""
      end

      def full_title(page_title)
        base_title = 'Hanami Sample App'
        page_title.empty? ? base_title : "#{page_title} | #{base_title}"
      end
    end
  end
end
