class Nulldiaries < ActiveRecord::Migration[7.0]
  def change
    change_column_null :diaries, :completed_work_size, true
  end
end
