uri = ENV['REDISCLOUD_URL']
Resque.redis = uri #Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)
