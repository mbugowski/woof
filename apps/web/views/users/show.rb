module Web::Views::Users
  class Show
    include Web::View

    def page_title
      user.name
    end

    def gravatar_for(user, options = { size: 80 })
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      size = options[:size]
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image(gravatar_url, alt: user.name, class: "gravatar")
    end
  end
end
