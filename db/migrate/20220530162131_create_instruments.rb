class CreateInstruments < ActiveRecord::Migration[7.0]
  def change
    create_table :instruments do |t|
      t.string :name, null: false
      t.string :description
      t.integer :location_id

      t.timestamps
    end
  end
end
