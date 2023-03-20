class Worker < ApplicationRecord
	has_many :diaries
	has_many :payments, as: :source
	audited
end
