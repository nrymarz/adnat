class SessionsController < ApplicationController
    def login
        @user = User.new
    end

    def create
        user = User.find_by(name: user_params[:name])
        if user && user.authenticate(user_params[:password])
            session[:user_id] = user.id
            redirect_to root_path
        else
            redirect_to login_path, notice:'No users found with the provided name and password'
        end
    end
end
