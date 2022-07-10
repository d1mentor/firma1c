class CreateGalleries < ActiveRecord::Migration[7.0]
  def change
    create_table :galleries do |t|
      t.string :name
      t.references :galleryable, polymorphic: true

      t.timestamps
    end
  end
end
