require 'rails_helper'

RSpec.describe SubscriptionTea, type: :model do
  describe 'relationships' do
    it { should belong_to(:subscription) }
    it { should belong_to(:tea) }
    it { should have_many(:customer_subscriptions).through(:subscription) }
    it { should have_many(:customers).through(:customer_subscriptions) }
  end
end
