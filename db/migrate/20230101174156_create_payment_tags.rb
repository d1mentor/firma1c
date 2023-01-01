class CreatePaymentTags < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_tags do |t|
      t.string :name
      t.string :comment

      t.timestamps
    end
  end
end
