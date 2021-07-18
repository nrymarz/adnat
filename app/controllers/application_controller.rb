class ApplicationController < ActionController::Base
    def current_user
        User.find(session[:user_id]) if session[:user_id]
    end

    def redirect_if_not_logged_in
        redirect_to login_path unless session[:user_id]
    end
end
