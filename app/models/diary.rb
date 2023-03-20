class Diary < ApplicationRecord
	belongs_to :worker
	belongs_to :work
	audited
end
