class AddCategoryIdToFriends < ActiveRecord::Migration[6.1]
  def change
    add_column :friends, :category_id, :integer
  end
end
