class Tea < ApplicationRecord
  has_many :subscription_teas
  has_many :subscriptions, through: :subscription_teas
  has_many :customer_subscriptions, through: :subscriptions
  has_many :customers, through: :customer_subscriptions

  validates :title, :description, :temperature, :brew_time, presence: true
  validates :temperature, :brew_time, numericality: { greater_than_or_equal_to: 0 }
end
