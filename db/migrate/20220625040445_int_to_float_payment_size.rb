class IntToFloatPaymentSize < ActiveRecord::Migration[7.0]
  def change
    change_column :payments, :size, :float
  end
end
