class Material < ApplicationRecord
	belongs_to :supply
	audited
end
