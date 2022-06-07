class AddHourPriceToWorks < ActiveRecord::Migration[7.0]
  def change
    add_column :works, :hour_price, :float
  end
end
