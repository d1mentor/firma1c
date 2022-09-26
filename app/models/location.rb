class Location < ApplicationRecord
	has_many :works
	has_many :supplies
	has_many :instruments
	has_many :notices

	has_many :galleries, as: :galleryable

	audited
end
