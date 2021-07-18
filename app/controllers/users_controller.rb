class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        if(user_params[:password] == user_params[:password_confirmation])
            password = user_params[:password]
            name = user_params[:name]
            email = user_params[:email]
            @user = User.new(name:name,password:password,email:email)
            if @user.save
                session[:user_id] = @user.id 
                redirect_to root_path
            else
                byebug
                render'new'
            end
        else
            render 'new'
        end
    end

    private

    def user_params
        params.require(:user).permit(:name,:password,:password_confirmation,:email)
    end
end
