require_relative './rate_limiter'

limiter = RateLimiter.new(30, 3)

stream = [
  { timestamp: 1700000010, user_id: 1 },
  { timestamp: 1700000011, user_id: 2 },
  { timestamp: 1700000012, user_id: 2 },
  { timestamp: 1700000020, user_id: 1 },
  { timestamp: 1700000025, user_id: 2 },
  { timestamp: 1700000031, user_id: 1 },
  { timestamp: 1700000033, user_id: 2 },
  { timestamp: 1700000035, user_id: 1 },
  { timestamp: 1700000040, user_id: 2 },
  { timestamp: 1700000042, user_id: 2 },
  { timestamp: 1700000045, user_id: 1 }
]

stream.each do |req|
  allowed = limiter.allow_request?(req[:timestamp], req[:user_id])
  puts "User #{req[:user_id]} at #{req[:timestamp]} => #{allowed ? 'ALLOWED' : 'BLOCKED'}"
end
