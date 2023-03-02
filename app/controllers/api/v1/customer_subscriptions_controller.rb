class Api::V1::CustomerSubscriptionsController < ApplicationController
  before_action :find_customer
  before_action :find_subscription

  def create
    if @customer.nil? || @subscription.nil?
      render json: { message: 'User or subscription invalid.' }, status: :bad_request
    else
      new_subscription = CustomerSubscription.new(customer: @customer, subscription: @subscription, frequency: params[:frequency], status: params[:status])
      if new_subscription.save
        render json: { message: "#{@customer.first_name} successfully subscribed." }, status: :created
      else
        render json: new_subscription.errors.messages, status: :bad_request
      end
    end
  end

  private

  def find_customer
    @customer = Customer.find_by(id: params[:customer_id])
  end

  def find_subscription
    @subscription = Subscription.find_by(id: params[:subscription_id])
  end
end
