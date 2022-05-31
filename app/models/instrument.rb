class Instrument < ApplicationRecord
	has_many :payments, as: :source
end
