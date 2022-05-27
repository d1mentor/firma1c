class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name, null: false, default: ""
      t.string :adress, null: false, default: ""
      t.string :description, null: false, default: ""
      t.boolean :flag, null: false, default: true
      t.string :photos_url, null: false, default: ""

      t.timestamps
    end
  end
end
