class Customer < ApplicationRecord
  has_many :customer_subscriptions
  has_many :subscriptions, through: :customer_subscriptions
  has_many :subscription_teas, through: :subscriptions
  has_many :teas, through: :subscription_teas

  validates :first_name, :last_name, :email, :address, presence: true
  validates :email, uniqueness: true
end
