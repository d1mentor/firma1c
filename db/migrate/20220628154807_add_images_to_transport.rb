class AddImagesToTransport < ActiveRecord::Migration[7.0]
  def change
    add_column :transports, :images, :json
  end
end
