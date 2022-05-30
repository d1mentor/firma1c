class Location < ApplicationRecord
	has_many :works
	has_many :supplies
end
