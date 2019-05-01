require_relative "../shared/gravatar_for"

module Web
  module Views
    module Home
      class Index
        include Web::View
        include Web::Controllers::Auth
        include Web::Views::Shared::GravatarFor

        def form
          form_for :micropost, routes.microposts_path do
            div class: "input" do
              errors_for(:content, self)
              label :content
              text_field :content, placeholder: "Compose new micropost..."
            end

            hidden_field :user_id, value: current_user.id

            submit "Post", class: "btn btn-primary"
          end
        end

        private

        def errors_for(attribute, context)
          return if params.valid?

          errors = params.errors.dig(:micropost, attribute)
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
  end
end
