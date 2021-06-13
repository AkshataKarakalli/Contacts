class Category < ApplicationRecord
    has_many :friends
    validates :category, uniqueness: true ,presence: true
end
