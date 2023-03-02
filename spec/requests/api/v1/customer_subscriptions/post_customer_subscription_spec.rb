require 'rails_helper'

RSpec.describe 'POST Customer Subscription' do
  describe 'Create Customer Subscription' do
    let!(:customer) { create(:customer) }
    let!(:new_subscription) { create(:subscription) }
    let!(:headers) { { 'Content-Type': 'application/json' } }

    it 'can create a customer subscription from a post request' do
      request = {
        customer_id: customer.id,
        subscription_id: new_subscription.id,
        frequency: :biweekly,
        status: :active
      }

      post '/api/v1/customer_subscriptions', headers: headers, params: JSON.generate(request)
      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response).to eq({ message: "#{customer.first_name} successfully subscribed." })
      expect(CustomerSubscription.last.customer_id).to eq(customer.id)
      expect(CustomerSubscription.last.status).to eq('active')
      expect(CustomerSubscription.last.frequency).to eq('biweekly')
    end

    it 'will return a relevant error message if user or subscription is not valid' do
      bad_user_request = {
        customer_id: 9001,
        subscription_id: new_subscription.id,
        frequency: :biweekly,
        status: :active
      }

      post '/api/v1/customer_subscriptions', headers: headers, params: JSON.generate(request)
      expect(response.status).to eq 400
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response).to eq({ message: 'User or subscription invalid.' })
    end

    it 'will return an appropriate error message if the request is invalid' do
      missing_status_request = {
        customer_id: customer.id,
        subscription_id: new_subscription.id,
        frequency: :weekly
      }

      post '/api/v1/customer_subscriptions', headers: headers, params: JSON.generate(missing_status_request)
      expect(response.status).to eq 400
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response).to eq({ status: ["can't be blank"] })
    end
  end
end
