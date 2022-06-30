class Transport < ApplicationRecord
	has_many :payments, as: :source
	has_many :galleries, as: :galleryable
end
