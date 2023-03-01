class CustomerSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription

  has_many :subscription_teas, through: :subscription
  has_many :teas, through: :subscription_teas

  validates :status, :frequency, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
