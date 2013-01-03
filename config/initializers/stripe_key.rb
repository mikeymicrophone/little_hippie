if Rails.env.production?
  Stripe.api_key = ENV['STRIPE_SECRET_KEY']
end