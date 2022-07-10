class ChangeDimensionIndex < ActiveRecord::Migration[7.0]
  def change
    change_column :works, :dimension, :string, null: true
    change_column :works, :size, :integer, null: true
  end
end
