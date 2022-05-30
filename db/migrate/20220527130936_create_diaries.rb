class CreateDiaries < ActiveRecord::Migration[7.0]
  def change
    create_table :diaries do |t|
      t.integer :worker_id, null: false
      t.integer :work_id, null: false
      t.float :completed_work_size, null: false
      t.date :date, null: false
      t.string :description, null: false, default: ""

      t.timestamps
    end
  end
end
