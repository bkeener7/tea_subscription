class SubscriptionTea < ApplicationRecord
  belongs_to :subscription
  belongs_to :tea

  has_many :customer_subscriptions, through: :subscription
  has_many :customers, through: :customer_subscriptions
end
