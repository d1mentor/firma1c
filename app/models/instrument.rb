class Instrument < ApplicationRecord
	has_many :payments, as: :source
	belongs_to :location
end
