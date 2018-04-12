class AddDescriptionToPoints < ActiveRecord::Migration[5.0]
  def change
    add_column :points, :description, :text
  end
end
