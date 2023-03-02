require 'rails_helper'

RSpec.describe 'POST Customer Subscription' do
  describe 'Create Customer Subscription' do
    it 'can create a customer subscription from a post request' do
      customer = create(:customer)
      new_subscription = create(:subscription)

      headers = { 'Content-Type': 'application/json' }

      request = {
        customer_id: customer.id,
        subscription_id: new_subscription.id,
        frequency: :biweekly,
        status: :active
      }

      post '/api/v1/customer_subscriptions', headers: headers, params: JSON.generate(request)

      expect(response).to be_successful
      expect(response.status).to eq 201

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response).to eq({ message: "#{customer.first_name} successfully subscribed." })
      expect(CustomerSubscription.last.customer_id).to eq(customer.id)
      expect(CustomerSubscription.last.status).to eq('active')
      expect(CustomerSubscription.last.frequency).to eq('biweekly')
    end

    xit 'will return a relevant error message if api key is invalid' do
      user = create(:user)
      favorites_info = {
        api_key: 'jgn983hy48thw9begh98h4539h4',
        country: 'Thailand',
        recipe_link: 'https://www.seriouseats.com/thai-style-fried-rice-crab-recipe',
        recipe_title: 'Thai-Style Crab Fried Rice Recipe'
      }

      headers = { 'Content-Type': 'application/json' }

      post '/api/v1/favorites', headers: headers, params: JSON.generate(favorites_info)

      expect(response).to_not be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 400
      expect(parsed_response[:message]).to eq('API key not valid')
    end

    xit 'will not save if new favorite params are invalid' do
      user = create(:user, api_key: 'jgn983hy48thw9begh98h4539h4')
      favorites_info = {
        api_key: 'jgn983hy48thw9begh98h4539h4',
        recipe_link: 'https://www.seriouseats.com/thai-style-fried-rice-crab-recipe',
        recipe_title: 'Thai-Style Crab Fried Rice Recipe'
      }

      headers = { 'Content-Type': 'application/json' }

      post '/api/v1/favorites', headers: headers, params: JSON.generate(favorites_info)

      expect(response).to_not be_successful

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 400
      expect(parsed_response[:message]).to eq("Country can't be blank")
    end
  end
end
