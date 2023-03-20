class Cutaway < ApplicationRecord
	has_many :galleries, as: :galleryable
end
