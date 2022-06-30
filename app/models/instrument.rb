class Instrument < ApplicationRecord
	has_many :payments, as: :source
	belongs_to :location
	has_many :galleries, as: :galleryable
end
