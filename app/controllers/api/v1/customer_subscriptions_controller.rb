class Api::V1::CustomerSubscriptionsController < ApplicationController
  before_action :find_customer
  before_action :find_subscription
  before_action :find_customer_subscription, only: [:update]

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

  def update
    if @customer.nil? || @subscription.nil? || @customer_subscription.nil?
      render json: { message: 'User or subscription invalid.' }, status: :bad_request
    elsif @customer_subscription.update(customer_subscription_params)
      render json: { message: "#{@customer.first_name}'s subscription is now #{@customer_subscription.status}." }, status: :ok
    else
      render json: { error: 'Unable to update subscription.' }, status: :bad_request
    end
  end

  private

  def find_customer
    @customer = Customer.find_by(id: params[:customer_id])
  end

  def find_subscription
    @subscription = Subscription.find_by(id: params[:subscription_id])
  end

  def find_customer_subscription
    @customer_subscription = CustomerSubscription.find_by(customer_id: params[:customer_id], subscription_id: params[:subscription_id])
  end

  def customer_subscription_params
    params.permit(:customer_id, :subscription_id, :frequency, :status)
  end
end
