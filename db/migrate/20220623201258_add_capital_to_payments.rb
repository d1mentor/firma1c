class AddCapitalToPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :capital, :boolean, default: false
  end
end
