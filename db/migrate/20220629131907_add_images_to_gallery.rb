class AddImagesToGallery < ActiveRecord::Migration[7.0]
  def change
    add_column :galleries, :images, :string, array: true, default: [] # add images column as array
  end
end
