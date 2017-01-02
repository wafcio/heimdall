class CreatePoints < ActiveRecord::Migration[5.0]
  def change
    create_table :points do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      add_address_fields(t)

      t.timestamps
    end
  end

  def add_address_fields(t)
    t.string :street_name
    t.string :street_number
    t.string :zip_code
    t.string :city
    t.string :state
    t.string :country
  end
end
