class Transport < ApplicationRecord
	has_many :payments, as: :source
end
