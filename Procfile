web: bundle exec unicorn -p $PORT -c ./config/initializers/unicorn.rb
resque: QUEUE=mailer rake environment resque:work
