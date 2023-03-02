class Api::V1::CustomerSubscriptionsController < ApplicationController
  def create
    customer = Customer.find(params[:customer_id])
    subscription = Subscription.find(params[:subscription_id])
    new_subscription = CustomerSubscription.new(customer: customer, subscription: subscription, frequency: params[:frequency], status: params[:status])

    if new_subscription.save
      render json: { message: "#{customer.first_name} successfully subscribed." }, status: :created
    else
      render json: { message: new_subscription.errors.full_message.to_sentence }, status: :bad_request
    end
  end
end
