class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        password = user_params[:password]
        name = user_params[:name]
        email = user_params[:email]
        @user = User.new(name:name,password:password,email:email)
        if(user_params[:password] == user_params[:password_confirmation])
            if @user.save
                session[:user_id] = @user.id 
                redirect_to root_path
            else
                render'new'
            end
        else
            flash[:notice] = "Password fields must match"
            render 'new'
        end
    end

    def update
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
