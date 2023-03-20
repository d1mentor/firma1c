class AddPaymentTagIdToPayment < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :payment_tag_id, :integer
  end
end
