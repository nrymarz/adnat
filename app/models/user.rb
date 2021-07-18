class User < ApplicationRecord
    has_secure_password
    has_many :shifts
    belongs_to :organisation, optional: true
    validates :email, uniqueness:true, presence:true
    validates :name, presence:true
end
