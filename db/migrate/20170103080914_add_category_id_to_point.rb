class AddCategoryIdToPoint < ActiveRecord::Migration[5.0]
  def change
    add_column :points, :category_id, :integer
  end
end
