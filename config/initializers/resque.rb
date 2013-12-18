uri = ENV['REDISCLOUD_URL']
Resque.redis = uri #Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)

Resque.before_fork do
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

Resque.after_fork do
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
