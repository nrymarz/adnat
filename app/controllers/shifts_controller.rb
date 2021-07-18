class ShiftsController < ApplicationController
    def index
        @organisation = Organisation.find_by(id:params[:organisation_id])
        if @organisation
            @shifts = @organisation.users.collect {|u| u.shifts}.flatten!
            @shifts.sort! do |a,b|
                a.start <=> b.start
            end
            @shift = Shift.new
        else
            redirect_to root_path, notice:"Organisation with that ID was not found"
        end
    end

    def create
    end

    def update
    end

    def destroy
    end

    def edit
        redirect_to root_path,status:403 && return if params[:id].to_i != session[:user_id]
    end

    private

    def shift_params
        params.require(:shift).permit(:user_id,:start,:finish,:break_length)
    end
end
