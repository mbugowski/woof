module Web::Controllers::Session
  class Create
    include Web::Action

    def call(params)
      params.env["warden"].authenticate!(:password)
      redirect_to routes.root_path
    end
  end
end
