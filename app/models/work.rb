class Work < ApplicationRecord
  belongs_to :location
  has_many :diaries
  belongs_to :customer
  has_many :payments, as: :source
  audited
end
