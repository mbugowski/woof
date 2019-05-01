require_relative "../shared/gravatar_for"

module Web::Views::Users
  class Followers
    include Web::View
    include Web::Views::Shared::GravatarFor

    def page_title
      title
    end

    def users
      followers
    end
  end
end
