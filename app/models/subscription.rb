class Subscription < ApplicationRecord
  has_many :customer_subscriptions
  has_many :subscription_teas
  has_many :customers, through: :customer_subscriptions
  has_many :teas, through: :subscription_teas

  validates :title, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
end
