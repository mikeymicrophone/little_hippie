if Rails.env.production?
  Stripe.api_key = ENV['STRIPE_SECRET_KEY']
end

if Rails.env.staging?
  Stripe.api_key = ENV['STRIPE_STAGING_SECRET_KEY']
end