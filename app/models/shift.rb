class Shift < ApplicationRecord
    belongs_to :user

    validates :start, presence:{message:"date and times must be filled out"}
    validates :break_length, presence: true, numericality:{greater_than_or_equal_to:0}

    def date=(obj)
        return if obj.any? {|k,v| v.empty?}
        start_date_time = DateTime.parse(obj[:start_date] + ' ' + obj[:start])
        finish_date_time = DateTime.parse(obj[:start_date] + ' ' + obj[:finish])
        self.start = start_date_time
        self.finish = finish_date_time
    end

    def hours_worked
        if(self.finish && self.start && self.break_length)
           hw = ((self.finish.hour*60 +self.finish.min) - (self.start.hour*60 + self.start.min) - self.break_length)/60.0
           hw += 24 if hw < 0 
        end
        hw
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
