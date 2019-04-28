module Web::Controllers::Session
  class Create
    include Web::Action
    include Hanami::Validations
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

    params do
      required(:session).schema do
        required(:email) { filled? & str? & size?(1..255) & format?(VALID_EMAIL_REGEX) }
        required(:password) { filled? & str? & size?(6..64) }
      end
    end

    def call(params)
      if params.valid?
        params.env["warden"].authenticate!(:password)
        redirect_to routes.root_path
      else
        self.status = 422
      end
    end
  end
end
