class CreateMaterials < ActiveRecord::Migration[7.0]
  def change
    create_table :materials do |t|
      t.string :name, null: false, default: ""
      t.float :count, null: false
      t.string :dimension, null: false, default: ""
      t.integer :supply_id, null: false

      t.timestamps
    end
  end
end
