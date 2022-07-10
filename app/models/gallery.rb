class Gallery < ApplicationRecord
	belongs_to :galleryable, polymorphic: true

	mount_uploaders :images, ImageUploader
end
