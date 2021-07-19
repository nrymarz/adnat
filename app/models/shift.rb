class Shift < ApplicationRecord
    belongs_to :user

    def date=(obj)
        start_date_time = DateTime.parse(obj[:start_date] + ' ' + obj[:start])
        finish_date_time = DateTime.parse(obj[:start_date] + ' ' + obj[:finish])
        self.start = start_date_time
        self.finish = finish_date_time
    end

    def date
    end
end
