class AddSomeDataToDiaries < ActiveRecord::Migration[7.0]
  def change
    add_column :diaries, :user_id, :integer
    add_column :diaries, :verified, :boolean
    add_column :diaries, :admin_id, :integer
  end
end
