class CustomerSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription

  has_many :subscription_teas, through: :subscription
  has_many :teas, through: :subscription_teas

  validates :status, :frequency, presence: true

  enum status: { inactive: 0, active: 1 }
  enum frequency: { weekly: 0, biweekly: 1, monthly: 2, quarterly: 3 }
end
