class Api::V1::SubscriptionsController < ApplicationController
  before_action :find_customer
  def index
    if @customer.nil?
      render json: { error: 'User not found' }, status: :not_found
    else
      render json: SubscriptionsSerializer.new(@customer.subscriptions)
    end
  end

  private

  def find_customer
    @customer = Customer.find_by(id: params[:customer_id])
  end
end
