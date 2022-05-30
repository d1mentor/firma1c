class Work < ApplicationRecord
	belongs_to :location
	has_many :diaries
	has_many :customers
end
