class CreateSupplies < ActiveRecord::Migration[7.0]
  def change
    create_table :supplies do |t|
      t.integer :supplier_id
      t.integer :location_id, null: false
      t.string :materials, null: false, default: ""
      t.string :description

      t.timestamps
    end
  end
end
