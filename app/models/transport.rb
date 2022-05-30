class Transport < ApplicationRecord
	has_many :payment, as: :source
end
