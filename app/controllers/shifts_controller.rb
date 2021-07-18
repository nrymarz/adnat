class ShiftsController < ApplicationController
    def index
    end

    def create
    end

    def update
    end

    def destroy
    end

    def edit
    end

    def new
    end

    private

    def shift_params
        params.require(:shift).permit(:user_id,:start,:finish,:break_length)
    end
end
