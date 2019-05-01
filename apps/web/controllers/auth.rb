module Web
  module Controllers
    module Auth
      def signed_in?
        params.env["warden"].authenticated?
      end

      def current_user?
        params.env["warden"].user.id == params[:id].to_i
      end

      def current_user
        params.env["warden"].user
      end
    end
  end
end
