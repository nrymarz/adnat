class OrganisationsController < ApplicationController
    before_action :redirect_if_not_logged_in
    def index
        @organisations = Organisation.all
        @user = current_user
        @organisation = @user.organisation || Organisation.new

    end

    def create
        @organisation = Organisation.new(name: organisation_params[:name], hourly_rate:organisation_params[:hourly_rate])
        if @organisation.save
            current_user.update(organisation_id:@organisation.id)
            redirect_to root_path, notice:"Joined #{@organisation.name}"
        else
            redirect_to root_path, notice:"Unable to create organisation"
        end
    end

    def update
        @organisation = Organisation.find_by(id: params[:id])
        @organisation.update(organisation_params)
        if @organisation.valid?
            redirect_to root_path, notice:"Succesfully updated #{@organisation.name}"
        else
            render 'edit'
        end
    end

    def edit
        @organisation = Organisation.find_by(id: params[:id])
        redirect_to root_path,notice:'Organisation not found' if !@organisation
    end

    private

    def organisation_params
        params.require(:organisation).permit(:name,:hourly_rate,:user_id)
    end
end
