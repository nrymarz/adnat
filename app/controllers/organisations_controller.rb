class OrganisationsController < ApplicationController
    before_action :redirect_if_not_logged_in
    def index
        @organisations = Organisation.all
        @user = current_user
    end

    def create
    end

    def update
    end

    def edit
    end
end
