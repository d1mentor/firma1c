class CreateWorks < ActiveRecord::Migration[7.0]
  def change
    create_table :works do |t|
      t.string :name, null: false, default: ""
      t.string :dimension, null: false, default: ""
      t.integer :size, null: false
      t.boolean :flag, null: false, default: true
      t.integer :location_id
      t.integer :customer_id

      t.timestamps
    end
  end
end
