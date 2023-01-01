class Payment < ApplicationRecord
	belongs_to :source, polymorphic: true, optional: true
	belongs_to :payment_tag, optional: true
	audited
end
