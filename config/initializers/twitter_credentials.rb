def twitter_client
  Twitter::REST::Client.new do |config|
    config.consumer_key = 'yX4aDmZuINOVnBmAtUCA'
    config.consumer_secret = 'WScPyFRQXCRFjf5BeskzB7YV7RQSmtU377kkFpoZ0Y'
    config.access_token        = "2399019596-tqFcnAhjgIJZZAbLoVjteRj4KsJV42VSIOIy4QF"
    config.access_token_secret = "Nxt8o3YyRNSMKhehmrrfo3OhRelcx5A8TR0sI46ITbqhh"
  end
end