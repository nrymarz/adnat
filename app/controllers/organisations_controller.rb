class OrganisationsController < ApplicationController
    before_action :redirect_if_not_logged_in
    def index
        @organisations = Organisation.all
        @user = current_user
        @organisation = @user.organisation || Organisation.new
    end

    def create
        @organisation = Organisation.new(organisation_params)
        if @organisation.save
            current_user.update(organisation_id:@organisation.id)
            redirect_to root_path, notice:"Joined #{@organisation.name}"
        else
            @user = current_user
            @organisations = Organisation.all
            render 'index'
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
        params.require(:organisation).permit(:name,:hourly_rate)
    end
end
