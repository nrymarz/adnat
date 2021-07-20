class PasswordresetsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:email])
        if @user
            PasswordMailer.with(user:@user).reset.deliver_now
            redirect_to root_path, notice:"An email was sent to reset your password"
        else
            flash[:notice] = "No user witht that email was found"
            render 'new'
        end
    end

    def edit
        @user = User.find_signed(params[:token], purpose:"password reset")
    end

    def update
        @user = User.find_signed(params[:token], purpose:"password reset")
        if @user.update(password_params)
            redirect_to login_path, notice: "Successfully changed password. Please Sign In"
        else
           render 'edit'
        end
    end

    private 
    
    def password_params
        params.require(:user).permit(:password,:password_confirmation)
    end
end
