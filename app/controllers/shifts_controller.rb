class ShiftsController < ApplicationController

    before_action :redirect_if_not_logged_in
    
    def index
        @user = current_user
        @organisation = Organisation.find_by(id:params[:organisation_id])
        if @organisation && @organisation.id == @user.organisation.id
            @shifts = @organisation.users.collect {|u| u.shifts}.flatten!
            @shifts.sort! do |a,b|
                a.start <=> b.start
            end
            @shift = Shift.new
        else
            redirect_to root_path, notice:"Unable to show page for that organisation"
        end
    end

    def create
        @shift = Shift.new(shift_params)
        if @shift.save
            redirect_to organisation_shifts_path(current_user.organisation)
        else
            @user = current_user
            @organisation = current_user.organisation
            @shifts = @organisation.users.collect {|u| u.shifts}.flatten!
            @shifts.sort! do |a,b|
                a.start <=> b.start
            end
            render 'index'
        end
    end

    def update
        @shift = Shift.find(params[:id])
        @shift.update(shift_params)
        if @shift.valid?
            redirect_to organisation_shifts_path(current_user.organisation)
        else
            @user = current_user
            render 'edit'
        end
    end

    def destroy
        user = User.find(params[:user_id])
        shift = Shift.find(params[:id])
        if user.id == session[:user_id].to_i
            user.shifts.delete(shift)
            redirect_to organisation_shifts_path(user.organisation)
        else
            redirect_to organisation_shifts_path(user.organisation), notice:"Cannot delete other users' shifts"
        end
    end

    def edit
        @user = User.find(params[:user_id])
        @shift = Shift.find(params[:id])
        if @user.id == session[:user_id].to_i
            render 'edit'
        else
            redirect_to organisation_shifts_path(@user.organisation), notice:"Cannot edit other users' shifts"
        end
    end

    private

    def shift_params
        params.require(:shift).permit(:user_id,:break_length,:date=>[:start_date,:start,:finish])
    end
end
