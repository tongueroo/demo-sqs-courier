class Message < ApplicationItem
  field :message
  validates :message, presence: true
end
