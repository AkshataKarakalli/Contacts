class AddDobToFriends < ActiveRecord::Migration[6.1]
  def change
    add_column :friends, :dob, :string
  end
end
