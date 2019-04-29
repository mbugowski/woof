require_relative "../shared/gravatar_for"

module Web::Views::Users
  class Edit
    include Web::View
    include Web::Views::Shared::GravatarFor

    def form
      form_for :user, routes.user_path(params[:id]), method: :patch, values: { user: user } do
        div class: "input" do
          errors_for(:name, self)
          label :name
          text_field :name
        end

        div class: "input" do
          errors_for(:email, self)
          label :email
          email_field :email
        end

        # TODO: add logic to prevent changing password to empty string
        #        div class: "input" do
        #          errors_for(:password, self)
        #          label :password
        #          password_field :password
        #        end

        submit "Register", class: "btn btn-primary"
      end
    end

    private

    def errors_for(attribute, context)
      return if params.valid?

      errors = params.errors.dig(:user, attribute)
      return if errors.nil? || errors.empty?

      context.div class: "errors" do
        ul do
          errors.each do |error|
            li "#{attribute.capitalize} #{error}"
          end
        end
      end
    end
  end
end
