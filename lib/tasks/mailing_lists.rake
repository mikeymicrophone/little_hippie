namespace :mailing_list do
  desc 'Populates country and state data'
  task :seed_states => :environment do
    require './db/state_country_seeds.rb'
  end
end