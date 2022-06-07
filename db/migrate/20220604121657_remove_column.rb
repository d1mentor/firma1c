class RemoveColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :supplies, :materials
  end
end
