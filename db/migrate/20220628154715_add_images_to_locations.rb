class AddImagesToLocations < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :images, :json
  end
end
