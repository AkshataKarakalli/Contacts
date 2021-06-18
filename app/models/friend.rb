class Friend < ApplicationRecord
require "csv"
require 'activerecord-import/base'
require  'activerecord-import/adapters/postgresql_adapter'

    validates :first_name, presence: true,
                length: {minimum: 5}
    validates :email, presence: true
    validates :last_name, presence: true
    validates :phone, presence: true,
                length: {maximum: 10}
    validates :gender, presence: true,
                 length: {maximum: 1}
                
    belongs_to :user
    belongs_to :category

    #def full_name
        #[first_name, last_name].join(' ')
    #end
    has_one_attached :image
    
    def self.to_csv 
        CSV.generate(headers: true) do |csv|
            csv << column_names
            all.each do |friend|
                csv << friend.attributes.values_at(*column_names)
            end
        end
    end
    
    def self.import(file)
        #friends = []
        CSV.foreach(file.path, headers: true) do |row|
            
            Friend.create! row.to_hash
         #friends << Friend.new(row.to_h)
        end
        #Friend.import friends,recursive: true
    end

        
end
