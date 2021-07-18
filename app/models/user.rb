class User < ApplicationRecord
    has_secure_password
    has_many :shifts
    belongs_to :organisation
end
