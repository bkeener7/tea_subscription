require 'rails_helper'

RSpec.describe 'PATCH Customer Subscription' do
  describe 'Cancel Customer Subscription' do
    let!(:customer) { create(:customer) }
    let!(:subscription) { create(:subscription) }
    let!(:customer_subscription) { create(:customer_subscription, customer: customer, subscription: subscription, status: :active) }
    let!(:headers) { { 'Content-Type': 'application/json' } }

    it 'can cancel a customer subscription from a patch request' do
      cancel_request = {
        customer_id: customer.id,
        subscription_id: subscription.id,
        frequency: :biweekly,
        status: :inactive
      }

      expect(CustomerSubscription.first.status).to eq('active')
      patch "/api/v1/customer_subscriptions/#{customer.id}", headers: headers, params: JSON.generate(cancel_request)
      expect(response.status).to eq 200
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response).to eq({ message: "#{customer.first_name}'s subscription is now inactive." })
      expect(CustomerSubscription.first.status).to eq('inactive')
    end

    it 'will return a relevant error message if user or subscription is not valid' do
      bad_user_request = {
        customer_id: 9001,
        subscription_id: subscription.id,
        frequency: :biweekly,
        status: :active
      }

      patch '/api/v1/customer_subscriptions/9001', headers: headers, params: JSON.generate(bad_user_request)
      expect(response.status).to eq 400
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response).to eq({ error: 'Unable to update subscription.' })
    end

    it 'will return an appropriate error message if the request is invalid' do
      missing_status_request = {
        customer_id: customer.id,
        subscription_id: subscription.id,
        frequency: :weekly
      }

      patch "/api/v1/customer_subscriptions/#{customer.id}", headers: headers, params: JSON.generate(missing_status_request)
      expect(response.status).to eq 400
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response).to eq({ error: 'Unable to update subscription.' })
    end
  end
end
