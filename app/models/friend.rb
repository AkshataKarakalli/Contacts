class Friend < ApplicationRecord
    validates :first_name, presence: true,
                length: {minimum: 5}
    validates :email, presence: true
                
    belongs_to :user

    def full_name
        [first_name, last_name].join(' ')
    end

    end
