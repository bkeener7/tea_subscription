require 'rails_helper'

RSpec.describe 'GET Customer Subscriptions' do
  describe 'Find customers active and inactive subscriptions' do
    let!(:customer) { create(:customer) }
    let!(:subscriptions) { create_list(:customer_subscription, 5, customer_id: customer.id) }
    let!(:headers) { { 'Content-Type': 'application/json' } }

    it 'can create return a customers active and inactive subscriptions' do
      get "/api/v1/customers/#{customer.id}/subscriptions", headers: headers
      expect(response.status).to eq 200
      parsed_response = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(parsed_response.count).to eq(5)
      expect(parsed_response.first.keys).to eq([:id, :type, :attributes])
    end

    it 'will return a relevant error message if user is not found' do
      get '/api/v1/customers/9001/subscriptions', headers: headers
      expect(response.status).to eq 404
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response).to eq({ error: 'User not found' })
    end
  end
end
