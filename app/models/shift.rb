class Shift < ApplicationRecord
    belongs_to :user

    validates :start, presence:{message:"date and times must be filled out"}
    validates :break_length, presence: true, numericality:{greater_than_or_equal_to:0}

    def date=(obj)
        return if obj.any? {|k,v| v.empty?}
        start_date_time = DateTime.parse(obj[:start_date] + ' ' + obj[:start])
        finish_date_time = DateTime.parse(obj[:start_date] + ' ' + obj[:finish])
        finish_date_time < start_date_time
        self.start = start_date_time
        self.finish = finish_date_time > start_date_time ? finish_date_time : finish_date_time.next
    end

    def hours_worked
        if(self.finish && self.start && self.break_length)
           hw = ((self.finish.hour*60 +self.finish.min) - (self.start.hour*60 + self.start.min) - self.break_length)/60.0
           hw += 24 if hw < 0 
           hw.round(2)
        end
    end

    def sunday_hours_worked
        shw = 0
        if self.start.sunday? && self.finish.sunday?
            shw = self.hours_worked
        elsif self.start.sunday?
            sunday_break_time = (self.break_length - (self.finish.hour*60 +self.finish.min))
            shw = 1440 - (self.start.hour*60 + self.start.min)
            shw -= sunday_break_time if sunday_break_time > 0
            shw = shw/60.0
        elsif self.finish.sunday?
            shw = (self.finish.hour*60 + self.finish.min) - self.break_length
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
        self.start.strftime('%D') if self.start
    end

    def finish_time
        self.finish.strftime('%l:%M%P') if self.finish
    end

    def start_time
        self.start.strftime('%l:%M%P') if self.start
    end
end
