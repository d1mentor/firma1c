class Location < ApplicationRecord
	has_many :works
	has_many :supplies
	has_many :instruments

	has_many :galleries, as: :galleryable
end
