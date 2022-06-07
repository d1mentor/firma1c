class Customer < ApplicationRecord
	has_many :works
	has_many :payments, as: :source
end
