class Shift < ApplicationRecord
    belongs_to :user

    validates :start, presence: true
    validates :finish, presence: true
    validates :break_length, presence: true, numericality:{greater_than_or_equal_to:0}

    validate :finish_after_start

    def date=(obj)
        return if obj.any? {|k,v| v.empty?}
        start_date_time = DateTime.parse(obj[:start_date] + ' ' + obj[:start])
        finish_date_time = DateTime.parse(obj[:start_date] + ' ' + obj[:finish])
        self.start = start_date_time
        self.finish = finish_date_time
    end

    def hours_worked
        if(self.finish && self.start && self.break_length)
            ((self.finish.hour*60 +self.finish.min) - (self.start.hour*60 + self.start.min) - self.break_length)/60.0
        end
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

    private

    def finish_after_start
        if self.hours_worked && self.hours_worked < 0
            errors.add(:finish, "Time must be after start time and duration worked should be longer than break length")
        else
            true
        end
    end
end
