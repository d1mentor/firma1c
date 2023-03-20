class Supply < ApplicationRecord
	belongs_to :location
	belongs_to :supplier, optional: true
	has_many :payments, as: :source
	has_many :materials, dependent: :destroy 
	audited
end
