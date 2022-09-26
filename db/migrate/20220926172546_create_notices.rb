class CreateNotices < ActiveRecord::Migration[7.0]
  def change
    create_table :notices do |t|
      t.string :text
      t.integer :location_id

      t.timestamps
    end
  end
end
