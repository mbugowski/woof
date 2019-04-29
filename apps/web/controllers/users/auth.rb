module Web
  module Controllers
    module Users
      module Auth
        def signed_in?
          params.env["warden"].authenticated?
        end

        def current_user?
          params.env["warden"].user.id == params[:id].to_i
        end
      end
    end
  end
end
