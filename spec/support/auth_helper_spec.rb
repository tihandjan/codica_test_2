module AuthHelper
    def auth_request user
        sign_in user
        request.headers.merge!(user.create_new_auth_token)
        user
    end
end