class CreateCutaways < ActiveRecord::Migration[7.0]
  def change
    create_table :cutaways do |t|

      t.timestamps
    end
  end
end
