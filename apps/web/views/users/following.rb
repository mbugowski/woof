require_relative "../shared/gravatar_for"

module Web::Views::Users
  class Following
    include Web::View
    include Web::Views::Shared::GravatarFor

    def page_title
      title
    end

    def users
      following
    end
  end
end
