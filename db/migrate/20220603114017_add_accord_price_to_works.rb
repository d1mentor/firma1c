class AddAccordPriceToWorks < ActiveRecord::Migration[7.0]
  def change
    add_column :works, :accord_price, :float
  end
end
