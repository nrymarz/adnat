class Shift < ApplicationRecord
    belongs_to :user

    validates :start, presence:{message:"date and times must be filled out"}
    validates :break_length, presence: true, numericality:{greater_than_or_equal_to:0}

    def date=(obj)
        return if obj.any? {|k,v| v.empty?}
        self.start = DateTime.parse(obj[:start_date] + ' ' + obj[:start])
        self.finish = DateTime.parse(obj[:start_date] + ' ' + obj[:finish])
        self.finish = finish.next if finish < start
    end

    def hours_worked
        if(finish && start && break_length)
           hw = ((finish.hour*60 +finish.min) - (start.hour*60 + start.min) - break_length)/60.0
           hw += 24 if hw < 0 
           hw.round(2)
        end
    end

    def sunday_hours_worked
        shw = 0
        if start.sunday? && finish.sunday?
            shw = hours_worked
        elsif start.sunday?
            sunday_break_time = (break_length - (finish.hour*60 +finish.min))
            shw = 1440 - (start.hour*60 + start.min)
            shw -= sunday_break_time if sunday_break_time > 0
            shw = shw/60.0
        elsif finish.sunday?
            shw = (finish.hour*60 + finish.min) - break_length
            shw = 0 if shw < 0
            shw = shw/60.0
        end
        shw
    end

    def sunday_bonus(hourly_rate)
        sunday_hours_worked * hourly_rate
    end


    def shift_cost(hourly_rate)
        hours_worked*hourly_rate + sunday_bonus(hourly_rate)
    end

    def date
        start.strftime('%D') if start
    end

    def finish_time
        finish.strftime('%l:%M%P') if finish
    end

    def start_time
        start.strftime('%l:%M%P') if start
    end
end
