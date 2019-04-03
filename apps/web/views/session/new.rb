module Web::Views::Session
  class New
    include Web::View

    def form
      form_for :session, routes.session_path do
        label :email
        email_field :email

        label :password
        password_field :password

        submit "Log in"
      end
    end
  end
end
