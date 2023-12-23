class Delivery < ApplicationRecord
  validates :message, presence: true
end
