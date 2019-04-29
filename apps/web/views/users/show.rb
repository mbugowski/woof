require_relative "../shared/gravatar_for"

module Web::Views::Users
  class Show
    include Web::View
    include Web::Views::Shared::GravatarFor

    def page_title
      user.name
    end
  end
end
