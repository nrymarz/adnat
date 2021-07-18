class SessionsController < ApplicationController
    def login
        @user = User.new
    end

    def create
        user = User.find_by(email: user_params[:email])
        if user && user.authenticate(user_params[:password])
            session[:user_id] = user.id
            redirect_to root_path
        else
            redirect_to login_path, notice:'No users found with the provided email and password'
        end
    end

    private

    def user_params
        params.require(:user).permit(:password,:email)
    end
end
