class AddHoursToDiaries < ActiveRecord::Migration[7.0]
  def change
    add_column :diaries, :hours, :integer
  end
end
