require 'rails_helper'

RSpec.describe CustomerSubscription, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should belong_to(:subscription) }
    it { should have_many(:subscription_teas).through(:subscription) }
    it { should have_many(:teas).through(:subscription_teas) }
  end

  describe 'validations' do
    it { should validate_presence_of :status }
    it { should validate_presence_of :frequency }
    it { should validate_numericality_of(:status).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:frequency).is_greater_than_or_equal_to(0) }
  end
end
