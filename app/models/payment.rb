class Payment < ApplicationRecord
	belongs_to :source, polymorphic: true, optional: true
end
