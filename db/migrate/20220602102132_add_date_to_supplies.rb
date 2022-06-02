class AddDateToSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :supplies, :date, :date
  end
end
