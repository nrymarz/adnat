class UsersController < ApplicationController
    before_action :redirect_if_not_logged_in, except: [:new,:create]
    def new
        if session[:user_id]
            redirect_to root_path, notice: "Already Logged In"
        else
            @user = User.new
            render 'new'
        end
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

    def edit
        @user = User.find(params[:id])
        redirect_to root_path, notice: "Not allowed to edit other users' profiles" if @user.id != session[:user_id].to_i
    end


    def update
        @user = current_user
        @user.update(user_params)
        if @user.valid?
            redirect_to root_path
        else
            render 'edit'
        end
    end

    def update_org
        @user = current_user
        @user.update(organisation_id: user_params[:organisation_id])
        @user.shifts.clear if @user.organisation_id.nil?
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
