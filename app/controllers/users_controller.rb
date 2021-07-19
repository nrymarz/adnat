class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id 
            redirect_to root_path
        else
            render'new'
        end
    end

    def update
        redirect_to root_path,status:403 && return if params[:id].to_i != session[:user_id]
        @user = current_user
        @user.update(user_params)
        if @user.valid?
            redirect_to root_path
        else
            redirect_to root_path, notice: "Unable to join that organisation"
        end
    end


    private

    def user_params
        params.require(:user).permit(:name,:password,:password_confirmation,:email,:organisation_id)
    end
end
