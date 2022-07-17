class Supplier < ApplicationRecord
	has_many :supplies
	audited
end
