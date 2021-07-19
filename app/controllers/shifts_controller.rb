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
        if params[:organisation_id] != current_user.organisation_id
            redirect_to root_path, notice:"Action prohibited", status:403
        end
        @shift = Shift.new(shift_params)
        if @shift.save
            redirect_to organisation_shifts_path(current_user.organisation)
        else
            render 'index'
        end
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
        params.require(:shift).permit(:user_id,:break_length,:date=>[:start_date,:start,:finish])
    end
end
