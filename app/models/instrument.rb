class Instrument < ApplicationRecord
	has_many :payment, as: :source
end
