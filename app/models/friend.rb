class Friend < ApplicationRecord
    validates :first_name, presence: true,
                length: {minimum: 5}
    validates :email, presence: true
                
    belongs_to :user
end
