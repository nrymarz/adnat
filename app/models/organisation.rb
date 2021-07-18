class Organisation < ApplicationRecord
    has_many :users
    has_many :shifts, through: :users
    validates :name, uniqueness:true, presence:true
    validates :hourly_rate, presence:true, numericality: {great_than_or_equal_to:5}
end
