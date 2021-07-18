class OrganisationsController < ApplicationController
    before_action :redirect_if_not_logged_in
    def index
        @organisations = Organisation.all
        @user = current_user
        @organisation = Organisation.new if @user.organisation.nil?
    end

    def create
        @organisation = Organisation.new(name: organisation_params[:name], hourly_rate:organisation_params[:hourly_rate])
        if @organisation.save
            User.find(:user_id).organisation = @organisation
            redirect_to root_path
        else
            redirect_to root_path, notice:"Unable to create organisation"
        end
    end

    def update
    end

    def edit
    end

    private

    def organisation_params
        params.require(:organisation).permit(:name,:hourly_rate,:user_id)
    end
end
