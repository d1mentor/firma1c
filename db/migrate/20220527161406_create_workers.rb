class CreateWorkers < ActiveRecord::Migration[7.0]
  def change
    create_table :workers do |t|
      t.string :name, null: false, default: ""
      t.string :position, null: false, default: ""
      t.string :company, null: false, default: ""
      t.string :description, null: false, default: ""
      t.string :phone, null: false, default: ""
      t.string :email, null: false, default: ""

      t.timestamps
    end
  end
end
