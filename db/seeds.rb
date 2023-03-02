customers = FactoryBot.create_list(:customer, 20)
subscriptions = FactoryBot.create_list(:subscription, 5)
teas = FactoryBot.create_list(:tea, 25)

customers.each do |customer|
  CustomerSubscription.create!(customer: customer, subscription: subscriptions.sample)
end

teas.each do |tea|
  SubscriptionTea.create!(tea: tea, subscription: subscriptions.sample)
end
