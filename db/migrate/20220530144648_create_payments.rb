class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.date :date
      t.integer :size, null: false
      t.string :description
      t.references :source, polymorphic: true

      t.timestamps
    end
  end
end
